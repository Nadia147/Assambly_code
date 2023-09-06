.model small
.stack 100h
.data
m db 'ddddddd $'
.code
main proc
       ;1 single key input
       ;2 single char output
       ;9 char string
       
       mov ax,@data
       mov ds,ax
       
       
       mov ah,9
       lea dx,m
       int 21h
       
       
 exit:    
   
    MOV AH,4CH         
    INT 21H
    MAIN ENDP
END MAIN      