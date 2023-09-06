.model small
.stack 100h
.data 

msg_1  db 'Input: $'  
msg_2 db 0ah,0dh,'Output: $'

.code

main proc
 
    mov ax,@data
    mov ds,ax 
    
    mov ah,9          
    lea dx,msg_1     
    int 21h 
 
    mov bx,0
    mov cl,1
    
    
     
 
    input:
       mov ah,1            
       int 21h             
       cmp al,0dh          
       je end
     
       cmp al,30h         
       jne 1_0           

       input_loop:
           sub al,30h      
                          
           shl bx,cl       
           or bl,al        

       jmp input  
       
       
       
     
    
    
    1_0:
      cmp al,31h        
     jmp input_loop 
     
     
    
   end: 
    
    
    mov ah,9          
    lea dx,msg_2     
    int 21h  
 
    mov ah,2              
    mov dl,0ah             
    int 21h                
    mov dl,0dh             
    int 21h
 
    mov cl,1
    mov ch,0
    output:
    
       cmp ch,4         
       je ans        
       inc ch           
       
       mov dl,bh       
       shr dl,4        
       
       cmp dl,0ah       
       jl l_10         
       add dl,37h       
       mov ah,2         
       int 21h          
       rol bx,4         
       jmp output       
       
    l_10:
        add dl,30h         
        mov ah,2
        int 21h            
        rol bx,4           
        jmp output         
              
     
    ans:  
    mov ah,4ch
    int 21h
           
   
   main endp
end main