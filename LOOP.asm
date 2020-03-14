;@utor Clog10

.286
PILA SEGMENT STACK
    DB 32 DUP('STACK_')
PILA ENDS

DATOS SEGMENT 
DATOS ENDS

CODIGO SEGMENT 'CODE'
    
    MAIN PROC FAR
    
    ASSUME CS:CODIGO, DS:DATOS, SS:PILA
    
     PUSH DS
     PUSH 0
     MOV AX, DATOS
     MOV DS, AX
      
     MOV CX,5
     LINEA1:
     PUSH CX
     MOV AH, 02H;Posicionar el Cursor
     MOV DH, 00H;Fila 5
     MOV DL, 28H;Columna 40 Dec
     INT 10H
     MOV CX,1
     LINEA2:
     
     MOV AH, 02H ;Salida del caracter
     MOV DL, 2AH ;Codigo ascii del caracter (*) 42 Dec
     INT 21H
     LOOP LINEA2
     POP CX
    LOOP LINEA1
   
    
       RET
     MAIN ENDP
 CODIGO ENDS
 END MAIN
     
