TITLE EXAMPLE: DIAMOND PRINT

.MODEL SMALL
.STACK 100H
.DATA  

INPUT DW ? 
LEVEL DW ?  
COUNT DW ? 
SPACE DW ?
LEVEL_FINAL DW ?

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
    MOV INPUT, 15
    
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
    MOV LEVEL_FINAL, BX
    
    ; SETTING COUNT NUMBER
    CMP REMAINDER, 0
    JE SET_TWO 
    
    MOV COUNT, 1 ; MOVE REMAINDER INTO COUNT
    JMP EXIT
    
    SET_TWO:
    MOV COUNT, 2
    
    EXIT:  
    
    ; STARTING PRINT (UPPER HALF)
    
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
    
    ; SETTING LEVEL
    MOV BX, LEVEL_FINAL
    MOV LEVEL, BX
    
    ; SETTING COUNT NUMBER - CHANGED 
    MOV BX, INPUT
    MOV COUNT, BX  
    
    ; STARTING PRINT (LOWER HALF)
    
    START_PRINT_2:
        MOV BX, INPUT
        SUB BX, COUNT
        
        ; DIVISION TO DETERMINE SPACE NUMBER    
        MOV DIVIDEND, BX
        MOV DIVISOR, 2
        
        MOV QUOTIENT, 0 
        MOV BX, DIVIDEND
        
        TOP_1_2:
            
            CMP BX, DIVISOR
            JL END_DIV_1_2   
            
            SUB BX, DIVISOR
            INC QUOTIENT
            JMP TOP_1_2
        END_DIV_1_2:  
        
        MOV BX, QUOTIENT
        MOV SPACE, BX 
        
        ; PRINTING SPACE
        MOV CX, SPACE
        
        MOV AH, 2
        MOV DL, 20H 
        
        JCXZ PRINT_STAR_2  ; NOTICE
        
        HERE_2:
            INT 21H 
        LOOP HERE_2
        
        ; PRINTING STAR
        PRINT_STAR_2: 
        MOV CX, COUNT
        
        MOV AH, 2
        MOV DL, '*'
        
        THERE_2:
            INT 21H 
        LOOP THERE_2     
        
        ; PRINTING NEWLINE
        LEA DX, NEWLINE
        MOV AH, 9
        INT 21H
        
        ; SETTING COUNT
        SUB COUNT, 2  ; CHANGED
            
        DEC LEVEL
        
        CMP LEVEL, 0
        JNE START_PRINT_2
    EXIT_PRINT_2:
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN