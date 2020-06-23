TITLE EXAMPLE: VID_   

; INCLUDE "EMU8086.INC"

.MODEL SMALL
.STACK 100H
.DATA      

T565 DB 'a'

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX  
    
    MOV AH, 2
    MOV DL, T565
    INT 21H 
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
 MAIN ENDP 
 
 END MAIN


