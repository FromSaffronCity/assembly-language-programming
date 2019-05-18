TITLE EXAMPLE: PYRAMID PRINT

.MODEL SMALL
.STACK 100H
.DATA  

INPUT DW ? 
LEVEL DW ?  
COUNT DW ? 
SPACE DW ?

DIVIDEND DW ?
DIVISOR DW ?
QUOTIENT DW ?
REMAINDER DW ?

NEWLINE DB 0AH, 0DH, '$'

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX   
    
    ; TAKING INPUT
    MOV INPUT, 23
    
    ; DIVISION FOR LEVEL NUMBER     
    MOV BX, INPUT
    MOV DIVIDEND, BX
    MOV DIVISOR, 2
    
    MOV QUOTIENT, 0 
    MOV BX, DIVIDEND
    
    TOP:
        
        CMP BX, DIVISOR
        JL END_DIV   
        
        SUB BX, DIVISOR
        INC QUOTIENT
        JMP TOP
    END_DIV:  
    
    MOV REMAINDER, BX 
    
    ; LEVEL NUMBER 
    MOV BX, QUOTIENT
    ADD BX, REMAINDER  
    MOV LEVEL, BX
    
    ; SETTING COUNT NUMBER
    CMP REMAINDER, 0
    JE SET_TWO 
    
    MOV COUNT, 1 ; MOVE REMAINDER INTO COUNT
    JMP EXIT
    
    SET_TWO:
    MOV COUNT, 2
    
    EXIT:  
    
    ; STARTING PRINT
    
    START_PRINT:
        MOV BX, INPUT
        SUB BX, COUNT
        
        ; DIVISION TO DETERMINE SPACE NUMBER    
        MOV DIVIDEND, BX
        MOV DIVISOR, 2
        
        MOV QUOTIENT, 0 
        MOV BX, DIVIDEND
        
        TOP_1:
            
            CMP BX, DIVISOR
            JL END_DIV_1   
            
            SUB BX, DIVISOR
            INC QUOTIENT
            JMP TOP_1
        END_DIV_1:  
        
        MOV BX, QUOTIENT
        MOV SPACE, BX 
        
        ; PRINTING SPACE
        MOV CX, SPACE
        
        MOV AH, 2
        MOV DL, 20H 
        
        JCXZ PRINT_STAR  ; NOTICE
        
        HERE:
            INT 21H 
        LOOP HERE
        
        ; PRINTING STAR
        PRINT_STAR: 
        MOV CX, COUNT
        
        MOV AH, 2
        MOV DL, '*'
        
        THERE:
            INT 21H 
        LOOP THERE     
        
        ; PRINTING NEWLINE
        LEA DX, NEWLINE
        MOV AH, 9
        INT 21H
        
        ; SETTING COUNT
        ADD COUNT, 2
            
        DEC LEVEL
        
        CMP LEVEL, 0
        JNE START_PRINT
    EXIT_PRINT:
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN