TITLE EXAMPLE: PROCEDURE_INTRO  

; INCLUDE "EMU8086.INC"

.MODEL SMALL
.STACK 100H
.DATA

PROMPT DB "INPUT: $"
RESULT DB "OUTPUT: $"
NEWLINE DB 0AH, 0DH, "$"   

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX 
    
    ; CALLING INPUT PROCEDURE
    CALL INPUT
    
    ; PRINTING NEWLINE
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    
    ; CALLING OUTPUT PROCEDURE
    CALL OUTPUT
    
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
 MAIN ENDP
    
 INPUT PROC
    LEA DX, PROMPT
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    MOV BL, AL
    
    RET   
 INPUT ENDP
 
 OUTPUT PROC
    LEA DX, RESULT
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DL, BL
    INT 21H
    
    RET   
 OUTPUT ENDP
 
 END MAIN




