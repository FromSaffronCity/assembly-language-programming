.MODEL SMALL
.STACK 100H
.CODE
 MAIN PROC
    MOV AH, 1             ; TAKING INPUTS IN REGISTERS
    INT 21H
    MOV BL, AL  
    INT 21H
    MOV CL, AL
               
    MOV AH, 2             ; PRINTING NEWLINE
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
              
    CMP BL, CL            ; COMPARING TWO REGISTERS BL, CL
    JE L1
                            
    MOV DL, '!'           ; JUMP SECTION
    INT 21H
    
    JMP EXIT 
    
    L1:                   
    MOV AH, 2
    MOV DL, '='
    INT 21H 
    
    EXIT:
        
    MOV AH, 4CH           ; FINISHING
    INT 21H
    MAIN ENDP
 END MAIN




