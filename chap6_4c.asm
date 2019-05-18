TITLE EXAMPLE: CHAP6_4C

.MODEL SMALL
.STACK 100H
.DATA   

.CODE
 MAIN PROC    
    ; MOV AX, @DATA
    ; MOV DS, AX    
    
    MOV CX, 5 
    MOV AH, 1
    
    TOP_IN: 
        INT 21H
    LOOP TOP_IN  
    
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    
    MOV CX, 5
    
    TOP_OUT:
        MOV DL, 'X'
        INT 21H
    LOOP TOP_OUT
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN