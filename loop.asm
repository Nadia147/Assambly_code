.model small
.stack 100h
.data
m db 'ddd $'
.code
main proc
    mov ax,@data
    mov ds,ax 
    
    mov ah,9
    lea dx,m
    int 21h
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    mov cx,10  
    mov ah,2
    mov dl,'a'  
    
    lv:
    int 21h
    add dl,3
    loop lv
    
    exit:    
   
    MOV AH,4CH         
    INT 21H
    MAIN ENDP
END MAIN     
    