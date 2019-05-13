TITLE EXAMPLE: VID_10     

.MODEL SMALL
.STACK 100H
.DATA      

MSG1 DB 'ENTER NUMBER: $'
MSG2 DB 0AH, 0DH, '   GREATER$'
MSG3 DB 0AH, 0DH, '   SMALLER$' 
MSG4 DB 0AH, 0DH, '   EQUAL$'

.CODE
 MAIN PROC
    ; INITIALIZING DATA SEGMENT
    MOV AX, @DATA
    MOV DS, AX    
    
    ; PRINTING PROMPT
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
      
    ; TAKING INPUT AND ADJUSTING
    MOV AH, 1
    INT 21H
    MOV BL, AL
              
    SUB BL, 48
    
    ; COMPARISON WITH 5
    CMP BL, 5     
    JE LABEL4
    
    CMP BL, 5
    JL LABEL3  
    
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    
    JMP EXIT
    
    LABEL3:
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
    
    JMP EXIT     
    
    LABEL4:
    LEA DX, MSG4
    MOV AH, 9
    INT 21H   
    
    EXIT: 
             
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN