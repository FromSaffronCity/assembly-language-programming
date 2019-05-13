TITLE EXAMPLE: VID_14

.MODEL SMALL
.STACK 100H
.DATA

MSG DB 'ENTER N: $'   

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
    
    SUB BL, 48
    
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H       
    
    MOV CX, 0
    MOV CL, BL
    MOV AH, 2
    MOV DL, '*'
        
    TOP:
        INT 21H
    LOOP TOP
      
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN




