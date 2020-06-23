TITLE EXAMPLE: SIGNED MULTIPLICATION ROUGH   

; INCLUDE "EMU8086.INC"

.MODEL SMALL
.STACK 100H
.DATA  

    PROMPT DB 0AH, 0DH, "ENTER NUMBER: $"
    OUTPUT DB 0AH, 0DH, "NUMBER: $"   
    
    ; NOTICE
    DIGIT_NUM DW ?  
    DIVISOR DW 10000
    IS_ZERO_END DB 0  ; TO AVOID PRINTING LEADING ZERO
    IS_NEGATIVE DB 0
    
    ;; NOTICE
    NUM_1 DW ?
    NUM_2 DW ?

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX
    
    ;; --- TAKING NUM_1 ---
    
    ;; PRINTING PROMPT 
    LEA DX, PROMPT
    MOV AH, 9
    INT 21H
    
    ;; CLEARING BX  
    XOR BX, BX              
    
    ;; TAKING INPUT (-32768 TO 32767)  
    FOR_IN:
        MOV AH, 1
        INT 21H
        
        CMP AL, 0DH
        JE END_FOR_IN
        
        CMP AL, '-'
        JNE CONTINUE_IN
        
        MOV IS_NEGATIVE, 1
        JMP FOR_IN         
        
        ; NOTICE
        CONTINUE_IN:
        XOR AH, AH  ; PREPARING AX
        AND AL, 0FH  ; CONVERTING ASCII DIGIT TO DECIMAL NUMBER
        MOV DIGIT_NUM, AX
        
        ; WORD-FORM MULTIPLICATION PART
        XOR DX, DX  ; CLEARING DX
        MOV AL, 10  
        MUL BX
        ADD AX, DIGIT_NUM
        MOV BX, AX
                  
        JMP FOR_IN          
    END_FOR_IN: 
    
    ;; PREPARING BX (INPUT)
    CMP IS_NEGATIVE, 1
    JNE CONTINUE_PROG
    
    NEG BX  ; NEGATE THE NEGATIVE INPUT (FOR FURTHER USE) 
    
    CONTINUE_PROG: 
    
    MOV NUM_1, BX
    MOV IS_NEGATIVE, 0  ; RESETTING IS_NEGATIVE
    
    ;; --- TAKING NUM_2 ---
    
    ;; PRINTING PROMPT 
    LEA DX, PROMPT
    MOV AH, 9
    INT 21H
    
    ;; CLEARING BX  
    XOR BX, BX              
    
    ;; TAKING INPUT (-32768 TO 32767)  
    FOR_IN_2:
        MOV AH, 1
        INT 21H
        
        CMP AL, 0DH
        JE END_FOR_IN_2
        
        CMP AL, '-'
        JNE CONTINUE_IN_2
        
        MOV IS_NEGATIVE, 1
        JMP FOR_IN_2         
        
        ; NOTICE
        CONTINUE_IN_2:
        XOR AH, AH  ; PREPARING AX
        AND AL, 0FH  ; CONVERTING ASCII DIGIT TO DECIMAL NUMBER
        MOV DIGIT_NUM, AX
        
        ; WORD-FORM MULTIPLICATION PART
        XOR DX, DX  ; CLEARING DX
        MOV AL, 10  
        MUL BX
        ADD AX, DIGIT_NUM
        MOV BX, AX
                  
        JMP FOR_IN_2          
    END_FOR_IN_2: 
    
    ;; PREPARING BX (INPUT)
    CMP IS_NEGATIVE, 1
    JNE CONTINUE_PROG_2
    
    NEG BX  ; NEGATE THE NEGATIVE INPUT (FOR FURTHER USE) 
    
    CONTINUE_PROG_2: 
    
    MOV NUM_2, BX
                  
    ;; --- FURTHER CODE ---
    MOV AX, NUM_1
    XOR DX, DX  ; CLEARING DX
    
    IMUL NUM_2  ; NOTICE: RESULT HERE
    XOR DX, DX  ; DONT NEED DX AS OUTPUT IS IN 16 BITS
    MOV BX, AX  ; RESULT
    MOV NUM_1, AX  ; RESULT              
    
    ;; PRINTING OUTPUT_MSG 
    LEA DX, OUTPUT
    MOV AH, 9
    INT 21H
    
    ;; PREPARING BX (OUTPUT) 
    MOV CX, 0
    MOV CL, 15
    SHR NUM_1, CL
    
    ; CHECKING SIGN BIT OF PRODUCT
    CMP NUM_1, 1
    JNE CONTINUE_PRINT 
    
    NEG BX  ; BX IS NOW POSITIVE 
    
    MOV AH, 2
    MOV DL, '-'
    INT 21H
    
    CONTINUE_PRINT:
    
    ;; SETTING DX:AX (ALSO SIGN EXTENSION OF DIVIDEND)
    MOV AX, BX
    XOR DX, DX  ; IMPORTANT 
        
    ;; PRINTING OUTPUT (BX)
    FOR_OUT:
        DIV DIVISOR  ; DIVISION TO EXTRACT DIGIT
        MOV DIGIT_NUM, AX  ; SAVING QUOTIENT
        MOV BX, DX  ; SAVING REMAINDER
        
        ; CONDITION CHECKING (NOTICE)  
        CMP DIGIT_NUM, 0
        JNE DISPLAY
        
        CMP IS_ZERO_END, 0
        JNE DISPLAY 
        
        ; CHECKING WHETHRE INPUT IS 0
        CMP DIVISOR, 1
        JNE CONTINUE
        
        MOV AH, 2
        MOV DX, BX  ; PRINT THE REMAINDER 
        OR DX, 30H  ; CONVERTING DECIMAL NUMBER TO ASCII DIGIT
        INT 21H
    
        JMP END_FOR_OUT    
        
        ; DIGIT PRINT
        DISPLAY:
        MOV IS_ZERO_END, 1  ; NOTICE
        
        MOV AH, 2
        MOV DX, DIGIT_NUM 
        OR DX, 30H  ; CONVERTING DECIMAL NUMBER TO ASCII DIGIT
        INT 21H        
        
        CONTINUE: 
        MOV DIGIT_NUM, BX  ; SAVING REMAINDER
        
        ; TERMINATION CONDITION
        CMP DIVISOR, 1
        JE END_FOR_OUT
        
        ; ADJUSTING DIVISOR
        MOV AX, DIVISOR
        XOR DX, DX  ; IMPORTANT
        
        MOV BX, 10
        DIV BX
        MOV DIVISOR, AX
        
        ; SETTING DX:AX
        MOV AX, DIGIT_NUM
        XOR DX, DX  ; IMPORTANT
            
        JMP FOR_OUT
    END_FOR_OUT:
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
 MAIN ENDP 
 
 END MAIN