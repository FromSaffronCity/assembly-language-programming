TITLE EXAMPLE: DECIMAL I/O (UNSIGNED)   

; INCLUDE "EMU8086.INC"

.MODEL SMALL
.STACK 100H
.DATA  

    PROMPT DB "ENTER NUMBER: $"
    OUTPUT DB 0AH, 0DH, "NUMBER: $"   
    
    ; NOTICE
    DIGIT_NUM DW ?  
    DIVISOR DW 10000
    IS_ZERO_END DB 0

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX
    
    ;; PRINTING PROMPT 
    LEA DX, PROMPT
    MOV AH, 9
    INT 21H
    
    ;; CLEARING BX  
    XOR BX, BX              
    
    ;; TAKING INPUT (0 TO 65535)
    FOR_IN:
        MOV AH, 1
        INT 21H
        
        CMP AL, 0DH
        JE END_FOR_IN 
        
        ; NOTICE
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
    
    ;; PRINTING OUTPUT_MSG 
    LEA DX, OUTPUT
    MOV AH, 9
    INT 21H
    
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