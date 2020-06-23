TITLE EXAMPLE: FACTORIAL

.MODEL SMALL
.STACK 100H
.DATA  

INPUT DW ?  

MULTIPLICAND DW ?
MULTIPLIER DW ? 

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
    
    ; INPUT HERE (NOT MORE THAN 7)
    MOV INPUT, 7
    
    CMP INPUT, 0
    JNE CONTINUE  
    
    MOV AH, 2
    MOV DX, '1'
    INT 21H
    
    JMP EXIT   
    
    CONTINUE:
    
    ; SETTING MULTIPLICAND, MULTIPLIER
    MOV BX, INPUT
    MOV MULTIPLICAND, BX
    DEC BX
    MOV MULTIPLIER, BX  
    
    ; FACTORIAL CALCULATION 
    FACTORIAL_START:   
        ; SETTING BX, CX
        MOV BX, 0
        MOV CX, MULTIPLIER
    
        TOP:
            ADD BX, MULTIPLICAND
        LOOP TOP
        
        ; VALUES SETTING
        MOV MULTIPLICAND, BX 
        DEC MULTIPLIER
        
        CMP MULTIPLIER, 0
        JNE FACTORIAL_START    
    FACTORIAL_END:
         
                      
    ; PRINT RESULT
    ; VALUES SETTING
    MOV NUMBER, BX
    MOV DIVISOR, 1000  
    MOV DIGIT, 0
    
    MOV AH, 2
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
        
        TOP_P:
            CMP BX, 10 
            JL END_TOP_P 
            
            SUB BX, 10
            INC QUOTIENT
            JMP TOP_P
        END_TOP_P:   
        
        MOV BX, QUOTIENT  
        MOV DIVISOR, BX
        MOV BX, REMAINDER     
        
        JMP PRINT_START
    PRINT_END: 
    
    EXIT:  
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN