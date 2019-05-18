TITLE EXAMPLE: DIVISION

.MODEL SMALL
.STACK 100H
.DATA

DIVIDEND DW ?
DIVISOR DW ? 
QUOTIENT DW ?
REMAINDER DW ?

NEWLINE DB 0AH, 0DH, '$'  ; '$' IS A MUST

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX 
             
    ; VALUE SETTING
    MOV DIVIDEND, 100
    MOV DIVISOR, 3
    
    MOV QUOTIENT, 0
    MOV CX, DIVIDEND 
    MOV BX, DIVIDEND
    
    TOP:
        
        CMP BX, DIVISOR
        JL END_DIV   
        
        SUB BX, DIVISOR
        INC QUOTIENT
        JMP TOP
    END_DIV:  
    
    MOV REMAINDER, BX
    
    MOV AH, 2
    MOV DX, QUOTIENT
    INT 21H
    
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DX, REMAINDER 
    ;ADD DX, 48
    INT 21H
            
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN


