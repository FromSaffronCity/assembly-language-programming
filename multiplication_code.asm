TITLE EXAMPLE: MULTIPLICATION

.MODEL SMALL
.STACK 100H
.DATA 

MULTIPLICAND DW ?
MULTIPLIER DW ?  

NEWLINE DB 0AH, 0DH, '$'

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX    
    
    ; VALUES SETTING
    MOV MULTIPLICAND, 20
    MOV MULTIPLIER, 6  
          
    MOV BX, 0      
    MOV CX, MULTIPLIER
    
    TOP:
        ADD BX, MULTIPLICAND
    LOOP TOP
    
    MOV AH, 2
    MOV DX, BX
    INT 21H
              
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
 MAIN ENDP
 
 END MAIN