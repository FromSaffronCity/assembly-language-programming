TITLE EXAMPLE: VID_18

.MODEL SMALL
.STACK 100H
.DATA   

.CODE
 MAIN PROC    
    ; MOV AX, @DATA
    ; MOV DS, AX
    
    MOV BX, 0  ; NOTICE - ASCII 0 (NOT ASCII 48)
    
    START:
        MOV CX, 0
        MOV CL, 16  ; I CAN DO THIS (FOR 16 ITERATIONS)
        
        TOP:
            MOV AH, 2
            MOV DL, 20H
            INT 21H
            
            MOV DL, BL
            INT 21H 
            
            INC BL
            
        LOOP TOP
        
        MOV AH, 2
        MOV DL, 0AH
        INT 21H
        MOV DL, 0DH
        INT 21H
        
        CMP BL, 0  ; BECAUSE (256)D = (1,00000000)2
        JNE START
    
    EXIT:  
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN