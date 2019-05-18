TITLE EXAMPLE: CHAPTER_6_PROBLEM

.MODEL SMALL
.STACK 100H
.DATA

PROMPT DB "TYPE A LINE OF TEXT:", 0AH, 0DH, '$'  
NO_CAPITAL DB 0AH, 0DH, "NO CAPITAL LETTER$" 
FIRST_CAPITAL DB 0AH, 0DH, "FIRST CAPITAL: $"
LAST_CAPITAL DB 0AH, 0DH, "LAST CAPITAL: $"

FIRST_LETTER DB 5BH
LAST_LETTER DB 40H 

IS_ATLEAST_ONE_CAPITAL DB 0

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX           
    
    LEA DX, PROMPT
    MOV AH, 9
    INT 21H   
    
    MOV AH, 1
    INT 21H
    
    WHILE:
        ; TERMINATION CHECK
        CMP AL, 0DH
        JE END_WHILE
        
        ; CAPITAL CHECK
        CMP AL, 'A'
        JL TAKE_NEXT
        CMP AL, 'Z'
        JG TAKE_NEXT
        
        MOV IS_ATLEAST_ONE_CAPITAL, 1  ; WE HAVE CAPITALS
        
        ; FIRST-LAST CHECKING
        CMP AL, FIRST_LETTER
        JGE NEXT_CHECK
        
        MOV FIRST_LETTER, AL
        
        NEXT_CHECK: 
        CMP AL, LAST_LETTER
        JLE TAKE_NEXT
        
        MOV LAST_LETTER, AL 
                    
        TAKE_NEXT:            
        MOV AH, 1
        INT 21H    
        
        JMP WHILE
    END_WHILE:  
    
    ; PRINTING RESULT
    CMP IS_ATLEAST_ONE_CAPITAL, 1
    JE ATLEAST_ONE_CAPITAL
    
    LEA DX, NO_CAPITAL
    MOV AH, 9
    INT 21H
    
    JMP EXIT
    
    ATLEAST_ONE_CAPITAL:   
    LEA DX, FIRST_CAPITAL
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DL, FIRST_LETTER
    INT 21H  
    
    LEA DX, LAST_CAPITAL
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DL, LAST_LETTER
    INT 21H
       
    EXIT: 
         
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN