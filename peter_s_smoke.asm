TITLE: OFFLINE_1 (UVA_10346, PETER_S_SMOKES)  

; INCLUDE "EMU8086.INC"

.MODEL SMALL
.STACK 100H
.DATA  
    
    ;; INPUT PURPOSE
    N DW ?  ; (DIVIDEND) 0 TO 65535
    K DW ?  ; (DIVISOR) 2 TO 65535 
    
    ;; I/O PURPOSE
    PROMPT_N DB "ENTER N (0 TO 65535): $"
    PROMPT_K DB 0AH, 0DH, "ENTER K (2 TO 65535): $"    
    OUTPUT_MSG DB 0AH, 0DH, "TOTAL CIGARETTES: $" 
    
    DIGIT_NUM DW ?  
    DIVISOR DW ?
    IS_ZERO_END DB ?  ; USED TO AVOID PRINTING LEADING ZERO 
    
    ;; UTILITY
    DOUBLE_NEWLINE DB 0AH, 0AH, 0DH, "$"
    ERROR_MSG DB 0AH, 0DH, "K MUST BE GREATER THAN 1$"     

.CODE
 MAIN PROC   
    ;; INITIALIZING DATA SEGMENT 
    MOV AX, @DATA
    MOV DS, AX 
    
    NEXT:
    
    ;; INPUT N
    LEA DX, PROMPT_N  ; PRINTING PROMPT
    MOV AH, 9
    INT 21H
    
    XOR BX, BX  ; CLEARING BX
    XOR CX, CX  ; CLEARING CX              
    
    FOR_IN_N:
        ; TAKING INPUT (0 TO 65535)  
        MOV AH, 1
        INT 21H
        
        CMP AL, 0DH
        JE END_FOR_IN_N
        
        MOV CX, 1  ; NOTICE: HERE, CX IS USED TO CHECK WHETHER PROGRAM SHOULD TERMINATE (ONLY 0DH INPUT) 
        
        ; NOTICE
        XOR AH, AH  ; PREPARING AX
        AND AL, 0FH  ; CONVERTING ASCII DIGIT TO DECIMAL NUMBER
        MOV DIGIT_NUM, AX
        
        ; WORD-FORM MULTIPLICATION PART
        XOR DX, DX  ; CLEARING DX
        MOV AL, 10  
        MUL BX
        ADD AX, DIGIT_NUM
        MOV BX, AX  ; BX HOLDS THE INPUT SO FAR
                  
        JMP FOR_IN_N          
    END_FOR_IN_N:
    
    CMP CX, 0  ; TERMINATION CONDITION
    JE EXIT
    
    MOV N, BX  ; SHIFTING INPUT TO N   
    
    ;; INPUT K
    LEA DX, PROMPT_K  ; PRINTING PROMPT
    MOV AH, 9
    INT 21H
    
    XOR BX, BX  ; CLEARING BX              
    
    FOR_IN_K:
        ; TAKING INPUT (2 TO 255)  
        MOV AH, 1
        INT 21H
        
        CMP AL, 0DH
        JE END_FOR_IN_K 
        
        ; NOTICE
        XOR AH, AH  ; PREPARING AX
        AND AL, 0FH  ; CONVERTING ASCII DIGIT TO DECIMAL NUMBER
        MOV DIGIT_NUM, AX
        
        ; WORD-FORM MULTIPLICATION PART
        XOR DX, DX  ; CLEARING DX
        MOV AL, 10  
        MUL BX
        ADD AX, DIGIT_NUM
        MOV BX, AX  ; BX HOLDS THE INPUT SO FAR
                  
        JMP FOR_IN_K          
    END_FOR_IN_K:
    
    MOV K, BX  ; SHIFTING INPUT TO K
    
    ;; CHECKING K
    CMP K, 2
    JAE CONTINUE 
    
    LEA DX, ERROR_MSG  ; PRINTING ERROR MESSAGE
    MOV AH, 9  
    INT 21H
    
    JMP NEWLINE  ; NOTICE
    
    ;; CALCULATION PART 
    CONTINUE:
    XOR BX, BX  ; CLEARING BX, CX
    XOR CX, CX
    
    MOV CX, N  ; SUM = CX HOLDS TOTAL SMOKED CIGARETTES
    MOV BX, N  ; USED = BX HOLDS TOTAL AVAILABLE BUTTS
    
    WHILE:
        CMP BX, K
        JB END_WHILE 
        
        ; INSIDE WHILE
        XOR DX, DX  ; CLEARING DX
        MOV AX, BX  ; PREPARING DIVIDEND
        DIV K  ; USED/K
        
        XOR BX, BX  ; CLEARING BX
        ADD BX, DX  ; USED = USED%K + USED/K (ADDING REMAINDER)
        ADD BX, AX  ; ADDING QUOTIENT
        
        ADD CX, AX  ; SUM += QUOTIENT
        JMP WHILE
    END_WHILE:
    
    ;; OUTPUT TOTAL NUMBER OF CIGARETTES (PRINTING CX) 
    LEA DX, OUTPUT_MSG  ; PRINTING OUTPUT_MSG
    MOV AH, 9
    INT 21H
        
    MOV AX, CX  ; SETTING DX:AX (ALSO SIGN EXTENSION OF DIVIDEND)
    XOR DX, DX  ; IMPORTANT 
    MOV DIVISOR, 10000  ; SETTING DIVISOR
    MOV IS_ZERO_END, 0  ; SETTING IS_ZERO_END 
        
    FOR_OUT:
        ; PRINTING OUTPUT (CX)
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
        JNE CONTINUE_OUT
        
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
        
        CONTINUE_OUT: 
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
    
    ;; PRINTING DOUBLE_NEWLINE
    NEWLINE:
    LEA DX, DOUBLE_NEWLINE
    MOV AH, 9
    INT 21H
    
    JMP NEXT
    
    EXIT:
          
    ;; FINISHING            
    MOV AH, 4CH           
    INT 21H
 MAIN ENDP 
 
 END MAIN