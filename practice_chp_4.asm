TITLE PRACTICE: CHAPTER 4

.MODEL SMALL
.STACK 100H
.DATA  

CR EQU 0DH
LF EQU 0AH

FIRST DB ?
MIDDLE DB ?
LAST DB ?        

PROMPT DB 'ENTER THREE INITIALS: $'

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX  
    
    ; PROBLEM-9 
    LEA DX, PROMPT
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    MOV FIRST, AL
    INT 21H
    MOV MIDDLE, AL
    INT 21H
    MOV LAST, AL
    
    MOV AH, 2
    MOV DL, LF
    INT 21H
    MOV DL, CR
    INT 21H  
    
    MOV DL, FIRST 
    INT 21H
    
    MOV DL, LF
    INT 21H
    MOV DL, CR
    INT 21H   
    
    MOV DL, MIDDLE    
    INT 21H
    
    MOV DL, LF
    INT 21H
    MOV DL, CR
    INT 21H
    
    MOV DL, LAST 
    INT 21H
    
    MOV DL, LF
    INT 21H
    MOV DL, CR
    INT 21H
    
    
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN