TITLE EXAMPLE: CHAPTER 6 PROBLEM 12

.MODEL SMALL
.STACK 100H
.DATA    

PROMPT DB 'ENTER A STRING OF CAPITAL LETTERS:', 0AH, 0DH, '$'
RESULT DB 0AH, 0DH, 'THE LONGEST CONSECUTIVELY INCREASING STRING IS:', 0AH, 0DH, '$'
         
START DB ?         
LENGTH DB 0
PREVIOUS DB ? 

FINAL_START DB ?
FINAL_LENGTH DB 0

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX  
    
    ; PRINTING PROMPT       
    LEA DX, PROMPT
    MOV AH, 9
    INT 21H
    
    ; TAKING FIRST INPUT
    MOV AH, 1 
    INT 21H 
    MOV FINAL_START, AL
    
    CMP FINAL_START, 0DH
    JE END_REPEAT  
    
    MOV START, AL 
    MOV PREVIOUS, AL
    INC LENGTH
    
    ; TAKING FURTHER INPUT
    REPEAT:
        INT 21H
        
        ; TERMINATION CONDITION
        CMP AL, 0DH
        JNE CONTINUE 
        
        MOV BH, LENGTH
        
        CMP FINAL_LENGTH, BH
        JGE END_REPEAT
        
        MOV FINAL_LENGTH, BH
        MOV BH, START
        MOV FINAL_START, BH
        
        JMP END_REPEAT
        
        ; CHECKING CONDITION 
        CONTINUE:
        MOV BL, AL
        SUB AL, PREVIOUS
        
        CMP AL, 1
        JNE START_NEW      
        
        ; STRING CAN INCREASE 
        MOV PREVIOUS, BL
        INC LENGTH 
        
        JMP REPEAT
        
        ; NEW STRING MUST START
        START_NEW:
        MOV BH, LENGTH
        
        CMP FINAL_LENGTH, BH 
        JGE CONTINUE_PROC 
        
        ; CHANGE FINAL_ PARAMETERS
        MOV FINAL_LENGTH, BH
        MOV BH, START
        MOV FINAL_START, BH 
        
        CONTINUE_PROC:
        MOV LENGTH, 0
        
        MOV START, BL
        MOV PREVIOUS, BL
        INC LENGTH
        
        JMP REPEAT
    END_REPEAT:
    
    ; PRINTING RESULT
    LEA DX, RESULT
    MOV AH, 9
    INT 21H
    
    MOV CX, 0
    MOV CL, FINAL_LENGTH   
    
    JCXZ EXIT  
    
    MOV AH, 2
    
    TOP:
        MOV DL, FINAL_START
        INT 21H
        
        INC FINAL_START    
    LOOP TOP
    
    EXIT: 
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN