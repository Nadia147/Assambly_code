.model small
.stack 100h 
.data
msg db 51
mg1 db ?
.code
 
 main proc
    
    mov ax,@data
    mov ds,ax
    
    ;mov ah,1
    ;int 21h
    ;mov msg,al  
    ;add msg,48
    
    mov ah,1
    int 21h
    mov mg1,al 
    ;add mg1,48
    
    mov ah,2
    mov dl,msg
    int 21h
    
    mov ah,2
    mov dl,mg1
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
 end main