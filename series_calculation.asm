TITLE PRACTICE: SUM CALCULATION

.MODEL SMALL
.STACK 100H
.DATA  

ARR DB 1, 3, 5, 7, 9, 11, 13, 15

.CODE
 MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; PART 1
    MOV BL, 0    
    MOV CX, 0
    MOV CL, 5
               
    LEA SI, ARR  ; SI = SOURCE INDEX
    
    MOV AH, 2
    
    FOR:   
        MOV DL, [SI]
        ADD DL, 48
        INT 21H  
        
        INC SI  
    LOOP FOR   
    
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    ; NOTICE - PART 2    
    MOV CX, 0
    MOV CL, 8       
    
    LEA SI, ARR
             
    FOR2:
        ADD BL, [SI] 
        INC SI
    LOOP FOR2       
    
    MOV AH, 2
    MOV DL, BL
    INT 21H 
    
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H      
    
    ; FINISHING
    MOV AH, 4CH               
    INT 21H
    MAIN ENDP   
 END MAIN