TITLE EXAMPLE: PRACTICE

.MODEL SMALL
.STACK 100H
.DATA   

.CODE
 MAIN PROC    
    ; MOV AX, @DATA
    ; MOV DS, AX  
    
    ; LOOPING
    MOV CX, 0
    MOV CL, 48
    MOV AH, 2
    MOV DL, CL
    
    ; NOTICE THE DIFFERENCE WITH ANOTHER LOOPING
    TOP:
        INT 21H
    LOOP TOP   
    
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    ; ANOTHER LOOPING
    MOV CX, 0
    MOV CL, 48
    MOV AH, 2
    
    TOP2:  
        MOV DX, CX
        INT 21H
    LOOP TOP2    
    
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    MOV DX, CX  ; NOTICE - NOW IT IS ZERO (NULL)
    INT 21H
    
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    ; NEGATION
    MOV BL, -47  ; 2'S COMPEMENT FRM OF -47 IS EQUAL TO BINARY REPRESENTATION OF 209
    MOV AH, 2
    MOV DL, BL
    INT 21H   
    
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    NEG BL
    MOV AH, 2
    MOV DL, BL
    INT 21H    
    
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    ; EXCHANGE INSTRUCTION
    MOV BL, 5
    MOV CL, 6
    
    ADD BL, 48
    ADD CL, 48
    
    MOV DL, BL  
    INT 21H
    MOV DL, CL
    INT 21H
    
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    XCHG BL, CL  
    
    MOV DL, BL   
    INT 21H
    MOV DL, CL 
    INT 21H
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN