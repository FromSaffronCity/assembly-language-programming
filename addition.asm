.MODEL SMALL
.STACK 100H
.CODE

 MAIN PROC
    MOV AH, 1
    INT 21H
    
    MOV BL, AL            ; TAKING TWO INPUTS
    INT 21H
    MOV CL, AL        
    
    ADD BL, CL            ; BL = BL+CL  (ADDITION OF ASCII VALUES)
    SUB BL, 48                      ; BL = BL-48
    
    MOV AH, 2              ; PRINTING NEWLINE
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    MOV DL, BL                 ; PRINTING SUM
    INT 21H  
    
    MOV AH, 4CH               ; FINISHING
    INT 21H
    MAIN ENDP
 END MAIN
      







