TITLE EXAMPLE: ONLINE

.MODEL SMALL
.STACK 100H
.DATA

; GENERAL PURPOSE
BIG DB ?
SMALL DB ? 
NUMBER DB ? 

SUM DW 0
COUNT DB 0

; DIVISION AND PRINTING PURPOSE
DIVIDEND DW ?  
DIVISOR DW ?
QUOTIENT DB ?
REMAINDER DW ?  

; NEWLINE
NEWLINE DB 0AH, 0DH, '$'

.CODE
 MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX 
    
    ;; TAKING INPUT NUMBER 
    MOV AH, 1
    INT 21H
    MOV BIG, AL  
    SUB BIG, 48
    INT 21H
    MOV SMALL, AL
    SUB SMALL, 48  
    
    MOV CX, 0
    MOV CL, 10
    MOV BX, 0
    
    TOP_PREP:  
        ADD BL, BIG
    LOOP TOP_PREP  
    
    ADD BL, SMALL
    MOV NUMBER, BL
    
    ;; PRINTING NEWLINE
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H 
    
    ;; CALCULATING SUM
    CMP NUMBER, 0
    JNE CONTINUE_SUM
    
    MOV AH, 2
    MOV DL, 30H ; THERE IS NO 1 IN BINARY REPRESENTATION OF SUM
    INT 21H
    
    JMP EXIT
    
    CONTINUE_SUM:
    MOV BX, 0  ; NOTICE
    MOV BL, 1
    
    TOP_SUM:
        ADD SUM, BX
        ADD BX, 2
        
        CMP BL, NUMBER
        JLE TOP_SUM
    END_TOP_SUM: 
    
    ;; DIVISION STARTS (TO COUNT 1 IN BINARY REPRESENTATION OF SUM)  
    
    
    ;; PRINTING COUNT    
    ; VALUES SETTING 
    MOV BX, COUNT  ; INPUT BASICALLY
      
    MOV DIVISOR, 10  ; NOTICE (COUNT WILL NOT BE MORE THANT 12)  
    MOV QUOTIENT, 0
    
    MOV AH, 2 
    
    PRINT_START: 
        ; EXTRACTING DIGIT(QUOTIENT)
        DIV_START_PRINT: 
            CMP BX, DIVISOR
            JL END_DIV_PRINT    
            
            SUB BX, DIVISOR
            INC QUOTIENT
            JMP DIV_START_PRINT
        END_DIV_PRINT:    
        
        ; PRINT DIGIT(QUOTIENT)
        MOV DL, QUOTIENT 
        ADD DL, 48
        INT 21H   
        
        ; TERMINATION CHECKING
        CMP DIVISOR, 1
        JE PRINT_END
        
        MOV REMAINDER, BX   
        
        ; SETTING DIVISOR  
        MOV BX, DIVISOR 
        MOV QUOTIENT, 0
        
        TOP_PRINT:
            CMP BX, 10 
            JL END_TOP_PRINT 
            
            SUB BX, 10
            INC QUOTIENT
            JMP TOP_PRINT
        END_TOP_PRINT:   
        
        ; PREPARING FOR NEXT ITERATION
        MOV BX, 0
        MOV BL, QUOTIENT  ; ADDITIONAL  
        MOV DIVISOR, BX
        MOV BX, REMAINDER 
        MOV QUOTIENT, 0    
        
        JMP PRINT_START
    PRINT_END:
    
    EXIT:     
          
    ; FINISHING            
    MOV AH, 4CH           
    INT 21H
    MAIN ENDP
 END MAIN