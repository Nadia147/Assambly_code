.MODEL SMALL
.STACK 100H
.DATA
     STR DB 0AH,0DH,'Illegal Input. $'
.CODE

MAIN PROC
 
    MOV AX,@DATA
    MOV DS,AX
 
    MOV BX,0
    MOV CL,1
 
    TOP:
       MOV AH,1            ; INPUT CHARACTER
       INT 21H             ; COMPARE IS CR OR NOT
       CMP AL,0DH          ; IF EQUAL JUMP TO END IF NO THAN CONTINUE
       JE END_
     
       CMP AL,30H          ; COMPARE AL CONTAIN 0 OR NOT
       JNE CHECK           ; IF NO GOTO CHECK

       CONTINUE:
           SUB AL,30H      ;SUBTRACT 30H AND PUT INTO AL
                           ;
           SHL BX,CL       ; SHIFT BX LEFT 1 TIME
           OR BL,AL        ; OR BL AND AL

       JMP TOP
    CHECK:
        CMP AL,31H         ;COMPARE AL CONTAIN 1 OR NOT
        JNE MSG            ; IF NO GOTO MSG
        JMP CONTINUE       ; IF YES THAN GOTO CONTINUE
    END_:  
 
    MOV AH,2               ;
    MOV DL,0AH             ;
    INT 21H                ;NEW LINE
    MOV DL,0DH             ;
    INT 21H
 
    MOV CL,1
    MOV CH,0
    OUTPUT:
          CMP CH,4         ;COMPARE CH IS EQUAL 4
          JE FINISH        ;IF YES GOTO FINISH
          INC CH           ;INCREMENT CH
       
          MOV DL,BH        ;MOVE BH TO DL
          SHR DL,4         ;SHIFT DL 4 TIMES IN THE RIGHT
       
          CMP DL,0AH       ;COMPARE DL < 10
          JL DIGIT         ;IF YES GOTO DIGIT
       
          ADD DL,37H       ;ADD DL WITH 37h
          MOV AH,2         ;
          INT 21H          ;PRINTING DL
          ROL BX,4         ;ROTATE BX LEFT 4 TIMES
          JMP OUTPUT       ;JUMP TO OUTPUT
       
    DIGIT:
        ADD DL,30H         ;ADD DL WITH 30h
        MOV AH,2
        INT 21H            ;PRINTING DL
        ROL BX,4           ;ROTATE BX LEFT 4 TIMES
        JMP OUTPUT         ;JUMP TO OUTPUT
    MSG:
        MOV AH,9           ;
        LEA DX,STR         ;ILLEGAL MSG
        INT 21H            ;
     
    FINISH:  
    MOV AH,4CH
    INT 21H
           
   
    MAIN ENDP
END MAIN