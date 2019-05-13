TITLE EXAMPLE: VID_13

.MODEL SMALL
.STACK 100H
.DATA

MSG DB 'ENTER THREE NUMBERS: $'  

.CODE
 MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG
    MOV AH, 9
    INT 21H     
    
    MOV AH, 1
    INT 21H
    MOV BL, AL
    
    MOV AH, 2
    MOV DL, 20H
    INT 21H    
    
    MOV AH, 1
    INT 21H
    MOV BH, AL
    
    MOV AH, 2
    MOV DL, 20H
    INT 21H
    
    MOV AH, 1
    INT 21H
    MOV CL, AL
    
    MOV AH, 2
    MOV DL, 0AH
    INT 21H 
    MOV DL, 0DH
    INT 21H
    
    ; COMPARISON
    CMP BL, BH
    JGE CONTINUE
    
    MOV BL, BH
    
    CONTINUE:
    CMP BL, CL
    JGE EXIT
    
    MOV BL, CL
    
    EXIT:   
    MOV AH, 2
    MOV DL, BL
    INT 21H
         
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN
    


