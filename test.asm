TITLE EXAMPLE: TEST

.MODEL SMALL
.STACK 100H
.DATA   

.CODE
 MAIN PROC    
    ; MOV AX, @DATA
    ; MOV DS, AX
    
    MOV BL, 7
    MOV BH, -3
    ADD BL, BH
    ADD BL, 48
    
    MOV AH, 2
    MOV DL, BL
    INT 21H   
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN
