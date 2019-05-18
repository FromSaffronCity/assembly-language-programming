TITLE EXAMPLE: CHAPTER_6_10_11

.MODEL SMALL
.STACK 100H
.DATA 

MSG1 DB 0AH, 0DH, "ENTER A HEX DIGIT: $"
MSG2 DB 0AH, 0DH, "IN DECIMAL, IT IS: $" 
MSG3 DB 0AH, 0DH, "CONTINUE ? $"  
MSG4 DB 0AH, 0DH, "INVALID INPUT, ENTER A VALID DIGIT$"

ERROR_COUNT DB 0 
INPUT DB ?

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX      
    
    TOP:
        LEA DX, MSG1
        MOV AH, 9
        INT 21H
        
        MOV AH, 1
        INT 21H
        MOV INPUT, AL
        
        ; CHECKING PART
        CMP INPUT, 30H
        JL ERROR
        CMP INPUT, 39H
        JLE PRINT_DECIMAL
        CMP INPUT, 46H
        JG ERROR
        CMP INPUT, 41H
        JGE PRINT_ABCDEF
        
        JMP ERROR
        
        PRINT_DECIMAL: 
        MOV ERROR_COUNT, 0  ; CLEARING ERROR COUNT
        
        LEA DX, MSG2
        MOV AH, 9
        INT 21H 
        
        MOV AH, 2 
        MOV DL, INPUT
        INT 21H  
        
        JMP CONTINUE  
        
        PRINT_ABCDEF: 
        MOV ERROR_COUNT, 0  ; CLEARING ERROR COUNT
        
        LEA DX, MSG2
        MOV AH, 9
        INT 21H 
        
        MOV AH, 2 
        MOV DL, '1'
        INT 21H 
        
        SUB INPUT, 'A'
        ADD INPUT, 48 
        
        MOV AH, 2 
        MOV DL, INPUT
        INT 21H 
        
        JMP CONTINUE        
        
        CONTINUE:
        LEA DX, MSG3
        MOV AH, 9
        INT 21H 
        
        MOV AH, 1
        INT 21H
        MOV BL, AL  ; CHOICE
        
        CMP BL, 'Y'
        JE TOP
        CMP BL, 'y'
        JE TOP
        
        JMP END_TOP
        
        ERROR:
        LEA DX, MSG4
        MOV AH, 9
        INT 21H
        
        INC ERROR_COUNT
        
        CMP ERROR_COUNT, 3
        JE END_TOP
              
        JMP TOP      
    END_TOP:
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN