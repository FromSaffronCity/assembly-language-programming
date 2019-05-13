TITLE PRACTICE: B2 ONLINE

.MODEL SMALL
.STACK 100H
.DATA            

CR EQU 0DH
LF EQU 0AH

PROMPT1 DB 'ENTER FIRST NUMBER: $' 
PROMPT2 DB 'ENTER SECOND NUMBER: $' 

EVEN DB 0AH, 0DH, "PRODUCT IS EVEN$"
ODD DB 0AH, 0DH, "PRODUCT IS ODD$"

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX   
    
    ; TAKING FIRST INPUT
    LEA DX, PROMPT1
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    INT 21H
    MOV BL, AL 
    SUB BL, 48
     
    ; NEWLINE
    MOV AH, 2
    MOV DL, LF
    INT 21H
    MOV DL, CR
    INT 21H   
    
    ; TAKING SECOND INPUT
    LEA DX, PROMPT2
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    INT 21H
    MOV BH, AL
    SUB BH, 48
    
    ; NEWLINE
    MOV AH, 2
    MOV DL, LF
    INT 21H
    MOV DL, CR
    INT 21H
    
    ; CHECKING
    CMP BL, 1
    JE NUMBER2_CHECKING 
    CMP BL, 3 
    JE NUMBER2_CHECKING
    CMP BL, 5
    JE NUMBER2_CHECKING
    CMP BL, 7
    JE NUMBER2_CHECKING
    CMP BL, 9
    JE NUMBER2_CHECKING
    
    JMP DISPLAY_EVEN
    
    NUMBER2_CHECKING: 
    
    CMP BH, 1
    JE DISPLAY_ODD 
    CMP BH, 3 
    JE DISPLAY_ODD
    CMP BH, 5
    JE DISPLAY_ODD
    CMP BH, 7
    JE DISPLAY_ODD
    CMP BH, 9
    JE DISPLAY_ODD
    
    DISPLAY_EVEN:
    LEA DX, EVEN
    MOV AH, 9
    INT 21H
    
    JMP EXIT  
    
    DISPLAY_ODD:
    LEA DX, ODD
    MOV AH, 9
    INT 21H
    
    EXIT:
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN