.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'IRON MAN$' 
MSG2 DB 'CAPTAIN AMERICA$'
.CODE

 MAIN PROC 
    MOV AX, @DATA      ; INITIALIZING DATA SEGMENT
    MOV DS, AX                    
    
    LEA DX, MSG1          ; LOAD EFFECTIVE ADDRESS (PRINTING STRING)
    MOV AH, 9
    INT 21H
    
    MOV AH, 2          ; PRINTING NEWLINE
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H 
    
    LEA DX, MSG2          ; PRINTING STRING
    MOV AH, 9
    INT 21H
    
    MOV AH, 4CH               ; FINISHING
    INT 21H
    MAIN ENDP
 END MAIN

