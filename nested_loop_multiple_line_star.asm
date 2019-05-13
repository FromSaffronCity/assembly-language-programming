TITLE EXAMPLE: VID_17

.MODEL SMALL
.STACK 100H
.DATA   

.CODE
 MAIN PROC    
    ; MOV AX, @DATA
    ; MOV DS, AX
    
    MOV AH, 1
    INT 21H  
    SUB AL, 48
    MOV BL, AL
    MOV BH, AL 
    
    ; NEWLINE
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    ; NESTED LOOP 
    MOV CX, 0  ; THIS LINE IS IMPORTANT AF
    MOV CL, BL ; CL FROM AL TO 1
    
    START:
        MOV BL, CL
    
        TOP:
            MOV AH, 2
            MOV DL, '*'
            INT 21H
            
            DEC BL
            
            CMP BL, 0
            JE EXIT
            
            JMP TOP
        EXIT:
           
        ; NEWLINE
        MOV AH, 2
        MOV DL, 0AH
        INT 21H
        MOV DL, 0DH
        INT 21H
    
    ; NOTICE
    LOOP START    
    
    ; NEWLINE
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    ; NESTED LOOP-2  
    MOV BL, BH
    ADD BH, 1  
    
    MOV CX, 0  ; THIS LINE IS IMPORTANT AF
    MOV CL, BL ; CL FROM AL TO 1
    
    START2:
        MOV BL, BH
        SUB BL, CL
    
        TOP2:
            MOV AH, 2
            MOV DL, '*'
            INT 21H
            
            DEC BL
            
            CMP BL, 0
            JE EXIT2
            
            JMP TOP2
        EXIT2:
           
        ; NEWLINE
        MOV AH, 2
        MOV DL, 0AH
        INT 21H
        MOV DL, 0DH
        INT 21H
    
    ; NOTICE
    LOOP START2 
        
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN