.MODEL SMALL
.STACK 100H
.DATA

VAR DB ?

.CODE
 MAIN PROC
    MOV AX, @DATA         ; INITIALIZING DATA SEGMENT
    MOV DS, AX
    
    MOV AH, 1             ; TAKING INPUT IN VAR
    INT 21H
    MOV VAR, AL       
    
    SUB VAR, 17           ; ADJUSTING VALUE
    
    MOV AH, 2             ; PRINTING NEWLINES AND OTHERS
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H     
    
    MOV DL, '1'
    INT 21H     
    MOV DL, VAR
    INT 21H    
    
    MOV AH, 4CH           ; FINISHING
    INT 21H
    MAIN ENDP
 END MAIN
    
    



