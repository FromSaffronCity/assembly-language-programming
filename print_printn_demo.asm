TITLE EXAMPLE: PRINT_PRINTN
                   
INCLUDE 'EMU8086.INC'                   
.MODEL SMALL
.STACK 100H
.DATA   

.CODE
 MAIN PROC    
    ; MOV AX, @DATA
    ; MOV DS, AX    
    
    XOR AX, AX
    MOV AX, 65
    
    PRINTN "HELLO WORLD"  
    PRINT "HELLO WORLD"
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN



