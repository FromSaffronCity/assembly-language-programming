TITLE EXAMPLE: PROTO_MULTIPLICATION

.MODEL SMALL
.STACK 100H
.DATA 

A_NUM DW ?
B_NUM DW ?  

NEWLINE DB 0AH, 0DH, '$'

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX    
    
    MOV AH, 1
    INT 21H
    MOV A_NUM, AX 
    SUB A_NUM, 48
    
    MOV AH, 1
    INT 21H
    MOV B_NUM, AX  
    SUB B_NUM, 48
    
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H  
          
    MOV BX, 0      
    MOV CX, B_NUM
    
    TOP:
        ADD BX, A_NUM
    LOOP TOP
    
    MOV AH, 2
    MOV DX, BX
    INT 21H
              
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
 MAIN ENDP
 
 END MAIN