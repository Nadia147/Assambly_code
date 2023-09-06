.model small
.stack 100h 
.data
msg db 51
mg1 db ?
.code
 
 main proc 
    
    
      exit:
    mov ah,4ch
    int 21h
    main endp
 end main