TITLE EXAMPLE: PRINT_BIG_NUMBER

.MODEL SMALL
.STACK 100H
.DATA   
     
NUMBER DW ?  ; BASICALLY DIVISOR
DIVISOR DW ?
DIGIT DW ? ; BASICALLY ANOTHER QUOTIENT
QUOTIENT DW ?
REMAINDER DW ?            

NEWLINE DB 0AH, 0DH, '$'

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX
    
    ; VALUES SETTING
    MOV NUMBER, 4565
    MOV DIVISOR, 1000  
    MOV DIGIT, 0
    
    MOV AH, 2 
    
    ; CHECKING NEGATIVE
    CMP NUMBER, 0
    JNL PRINT 
    
    NEG NUMBER
    MOV DL, '-'
    INT 21H
    
    PRINT:
    MOV BX, NUMBER
    
    PRINT_START: 
        ; EXTRACTING DIGIT
        DIV_START: 
            CMP BX, DIVISOR
            JL END_DIV    
            
            SUB BX, DIVISOR
            INC DIGIT
            JMP DIV_START
        END_DIV:    
        
        ; PRINT DIGIT
        MOV DX, DIGIT 
        ADD DX, 48
        INT 21H   
        
        ; TERMINATION CHECKING
        CMP DIVISOR, 1
        JE PRINT_END
        
        MOV REMAINDER, BX 
        
        ; RESETTING DIGIT
        MOV DIGIT, 0  
        
        ; SETTING DIVISOR  
        MOV BX, DIVISOR 
        MOV QUOTIENT, 0
        
        TOP:
            CMP BX, 10 
            JL END_TOP 
            
            SUB BX, 10
            INC QUOTIENT
            JMP TOP
        END_TOP:   
        
        MOV BX, QUOTIENT  
        MOV DIVISOR, BX
        MOV BX, REMAINDER     
        
        JMP PRINT_START
    PRINT_END:    
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN