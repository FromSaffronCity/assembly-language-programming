TITLE EXAMPLE: VID_16

.MODEL SMALL
.STACK 100H
.DATA   

.CODE
 MAIN PROC    
    ; MOV AX, @DATA
    ; MOV DS, AX 
    
    MOV AH, 1
    INT 21H
    MOV BL, AL 
    
    ; FIRST LIST
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    MOV CL, '1'
    
    TOP:
        MOV AH, 2
        MOV DL, CL
        INT 21H
        
        INC CL
        
        CMP BL, CL
        JL EXIT
        
        JMP TOP
    EXIT:  
       
    ; SECOND LIST
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    MOV CL, BL
    
    TOP2:
        MOV AH, 2
        MOV DL, CL
        INT 21H
        
        DEC CL
        
        CMP CL, 49  ; NOTICE
        JL EXIT2
        
        JMP TOP2
    EXIT2:
    
    ; THIRD LIST
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    SUB BL, 48 
    
    MOV CX, 0
    MOV CL, BL 
    
    ADD BL, 48
    
    TOP3:   
        MOV AH, 2
        MOV DL, BL 
        INT 21H   
        DEC BL
    LOOP TOP3
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN


