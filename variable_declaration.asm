.MODEL SMALL
.STACK 100H
.DATA                      ; DATA SEGMENT STARTS

VAR1 DB 4                  ; VARIABLE DECLARATION IN DATA SEGMENT     
VAR2 DB ?

.CODE                      ; CODE SEGMENT STARTS
 MAIN PROC
    MOV AX, @DATA          ; INITIALIZING DATA SEGMENT
    MOV DS, AX                   
    
    MOV AH, 1              ; TAKING INPUT (INTEGER INPUT IS ACCEPTED AS THE NUMBER NOT ASCII VALUE)
    INT 21H
    MOV VAR2, AL                      
    
    ADD VAR1, 48           ; ADJUSTING VALUES  
    
    
    MOV AH, 2              ; PRINTING VAR VALUES AND NEWLINES
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    MOV DL, VAR1
    INT 21H      
    
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    
    MOV DL, VAR2
    INT 21H

    MOV AH, 4CH            ; FINISHING
    INT 21H
    MAIN ENDP
 END MAIN


