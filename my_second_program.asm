.MODEL SMALL
.STACK 100H
.CODE

 MAIN PROC
    MOV AH, 1
    INT 21H
    
    MOV BL, AL            ; TAKING MULTIPLE INPUTS
    INT 21H
    MOV BH, AL
    INT 21H
    MOV CL, AL
    INT 21H
    MOV CH, AL    
    
    MOV AH, 2              ; PRINTING NEWLINE
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    MOV DL, BL                 ; PRINTING MULTIPLE VALUES
    INT 21H  
    MOV DL, BH
    INT 21H
    MOV DL, CL
    INT 21H
    MOV DL, CH
    INT 21H
    
    MOV AH, 4CH               ; FINISHING
    INT 21H
    MAIN ENDP
 END MAIN
      


