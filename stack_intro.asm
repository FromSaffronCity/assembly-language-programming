TITLE EXAMPLE: STACK_INTRO 

; INCLUDE "EMU8086.INC"

.MODEL SMALL
.STACK 100H
.DATA

PROMPT DB "ENTER STRING: $"
RESULT DB 0AH, 0DH, "REVERSED STRING: $"   

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX 
    
    ; PRINTING PROMPT
    LEA DX, PROMPT
    MOV AH, 9
    INT 21H
    
    ; CLEARING CX
    XOR CX, CX
    
    ; TAKING INPUT   
    MOV AH, 1
    
    INPUT:
        INT 21H
        
        CMP AL, 0DH  ; EXIT FOR CARRAIGE RETURN
        JE EXIT_INPUT
                     
        PUSH AX  ; NOTICE (CAN'T PUSH AL) 
        INC CX
        JMP INPUT             
    EXIT_INPUT:
    
    ; PRINTING RESULT
    LEA DX, RESULT
    MOV AH, 9
    INT 21H 
    
    ; PRINTING OUTPUT
    MOV AH, 2
     
    OUTPUT:
        POP DX  ; NOTICE (CAN'T POP IN DL)
        INT 21H ; NOTICE: IT ONLY WORKS WITH DL PART
    LOOP OUTPUT
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN