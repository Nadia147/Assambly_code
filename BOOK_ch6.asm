.MODEL SMALL
.STACK 100H
.CODE

MAIN PROC
    MOV CX,4
    MOV AH,2
    MOV DL,'%'
    TOP:
    INT 21H
    LOOP TOP
 END MAIN
