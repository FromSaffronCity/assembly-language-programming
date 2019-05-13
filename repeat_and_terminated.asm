TITLE EXAMPLE: VID_11     

.MODEL SMALL
.STACK 100H
.DATA             
       
.CODE
 MAIN PROC    
    L1: 
    
    ; INPUT
    MOV AH, 1
    INT 21H
    MOV BL, AL
    
    ; OUTPUT  
    MOV AH, 2
    MOV DL, 20H
    INT 21H
    MOV DL, BL
    INT 21H
    
    ; PRINTING NEWLINE
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    ; TERMINATION CONDITION CHECKING (# FOR TERMINATION)
    CMP BL, 35 ; ASCII VALUE
    JE EXIT
    
    JMP L1
    
    EXIT:   
             
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN




