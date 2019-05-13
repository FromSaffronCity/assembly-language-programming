TITLE EXAMPLE: VID_12

.MODEL SMALL
.STACK 100H
.DATA

MSG1 DB 'ENTER NUMBER: $'
MSG2 DB 0AH, 0DH, 'IN RANGE$'
MSG3 DB 0AH, 0DH, 'NOT IN RANGE$'  

.CODE
 MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 9
    INT 21H     
    
    MOV AH, 1
    INT 21H
    MOV BL, AL
    
    SUB BL, 48
              
    ; RANGE [4, 7]
    CMP BL, 4
    JL L1 
    
    CMP BL, 7
    JG L1 
    
    LEA DX, MSG2
    MOV AH, 9
    INT 21H 
    
    JMP EXIT
    
    L1:
    
    LEA DX, MSG3
    MOV AH, 9
    INT 21H  
    
    EXIT:
         
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN
    


