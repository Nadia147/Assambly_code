.MODEL SMALL
.STACK 100H

.DATA
   MSG1  DB  'Enter the time in seconds up to 65535 = $'
   MSG2  DB  0DH,0AH,'The time in hh:mm:ss format is = $'
   CHAR DB  ' : $'

 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX

     LEA DX, MSG1                 ; display the string MSG1
     MOV AH, 9
     INT 21H

     CALL INDEC                   ; call the procedure INDEC

     PUSH AX
                                     
     LEA DX, MSG2                 ; display the string MSG2
     MOV AH, 9
     INT 21H

     POP AX                       

     XOR DX, DX                  
     MOV CX, 3600                 ; set CX=3600
     DIV CX                       ; set AX=DX:AX\\CX , DX=DX:AX%CX

     CMP AX, 10                   ; compare AX with 10
     JGE HOURS                    ; jump to label HOURS if AX>=10

     PUSH AX                     

     MOV AX, 0                    ; set AX=0
     CALL OUTDEC                  ; call the procedure OUTDEC

     POP AX                      

     HOURS:                  
     CALL OUTDEC                  ; call the procedure OUTDEC

     MOV AX, DX                 

     PUSH AX                      

     LEA DX, CHAR                 ; display the string SEPARATOR
     MOV AH, 9
     INT 21H

     POP AX                       
     XOR DX, DX                   

     MOV CX, 60                   ; set CX=60
     DIV CX                       ; set AX=DX:AX\\CX , DX=DX:AX%CX

     CMP AX, 10                   ; compare AX with 10
     JGE MINUTES                  ; jump to label MINUTES if AX>=10

     PUSH AX                    

     MOV AX, 0                   
     CALL OUTDEC                  ; call the procedure OUTDEC

     POP AX                       

     MINUTES:                    
     CALL OUTDEC                  ; call the procedure OUTDEC

     MOV BX, DX                 

     LEA DX, CHAR                 ; display the string SEPARATOR
     MOV AH, 9
     INT 21H

     MOV AX, BX                  

     CMP AX, 10                   ; compare AX with 10 
     JGE SECONDS                  ; jump to label @SECONDS if AX>=10

     PUSH AX                      

     MOV AX, 0                  
     CALL OUTDEC                  ; call the procedure OUTDEC

     POP AX                       

     SECONDS:                  
     CALL OUTDEC                  ; call the procedure OUTDEC

     MOV AH, 4CH                  ; return control to DOS
     INT 21H
   MAIN ENDP


 INDEC PROC
   
   PUSH BX                      
                     
   XOR BX, BX                     ; clear BX

   START:    

       MOV AH,1                   ; read a character
       INT 21H
       CMP AL,0DH
       JE NEXT
       AND AX,000FH
       PUSH AX 
       MOV AX,10
       MUL BX
       MOV BX,AX
       POP AX
       ADD BX,AX
       LOOP START
  NEXT: 
   MOV AX,BX
   
   POP BX                         

   RET                           
 INDEC ENDP

 OUTDEC PROC

   PUSH BX                        
   PUSH CX                   
   PUSH DX                        

   @START:                       

   XOR CX, CX                     
   MOV BX, 10                     ; set BX=10

   @OUTPUT:                      
     XOR DX, DX                
     DIV BX                     
     PUSH DX                   
     INC CX                      
     OR AX, AX                 
   JNE @OUTPUT                    ; jump to label @OUTPUT if ZF=0

   MOV AH, 2                      

   @DISPLAY:                    
     POP DX                       
     OR DL, 30H                   ; convert decimal to ascii code
     INT 21H                      ; print a character
   LOOP @DISPLAY                  ; jump to label @DISPLAY if CX!=0

   POP DX                        
   POP CX                         
   POP BX                         

   RET                           
 OUTDEC ENDP


 END MAIN