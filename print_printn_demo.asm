TITLE EXAMPLE: DEMO
                   
INCLUDE 'EMU8086.INC'                   
.MODEL SMALL
.STACK 100H
.DATA   

.CODE
 MAIN PROC    
    ; MOV AX, @DATA
    ; MOV DS, AX     
    
    PRINTN "HELLO WORLD"  
    PRINT "HELLO WORLD"
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN



