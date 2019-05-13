TITLE EXAMPLE: VID_15

.MODEL SMALL
.STACK 100H
.DATA

MSG DB 'INPUT NUMBER: $'   

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
      
    ; NOTICE
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
             
    ; XOR CX, CX
    MOV CX, 0
    MOV CL, BL
    
    ADD BL, 48
    
    TOP:
        MOV AH, 2
        MOV DL, BL
        INT 21H
        DEC BL 
    LOOP TOP
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN




