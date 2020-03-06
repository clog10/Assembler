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
     
     MOV CX, 3   ;Cantidad de * a imprimir
     
;-----LINEA UNO---------    
     MOV AH, 02H;Posicionar el Cursor
     MOV DH, 00H;Fila 0
     MOV DL, 28H;Columna 40 Dec
     INT 10H
     
     MOV AH, 02H;Salida del caracter
     MOV DL, 2AH;Codigo ascii del caracter (*) 42 Dec
     INT 21H
     
;------LINEA DOS-------     
     MOV AH, 02H ;Posicionar el Cursor
     MOV DH, 01H ;Fila 1
     MOV DL, 27H ;Columna 39 Dec
     INT 10H
      
    LINEA2:
     MOV AH, 02H ;Salida del caracter
     MOV DL, 2AH ;Codigo ascii del caracter (*) 42 Dec
     INT 21H
     LOOP LINEA2
     
;------LINEA TRES------  
     MOV CX, 5    ;Cantidad de * a imprimir
        
     MOV AH, 02H ;Posicionar el Cursor
     MOV DH, 02H  ;Fila 2
     MOV DL, 26H  ;Columna 38 Dec
     INT 10H
     
     LINEA3:
     MOV AH, 02H ;Salida del caracter
     MOV DL, 2AH ;Codigo ascii del caracter (*) 42 Dec
     INT 21H
     LOOP LINEA3
     
;------LINEA CUATRO------  
     MOV CX, 7  ;Cantidad de * a imprimir
        
     MOV AH, 02H ;Posicionar el Cursor
     MOV DH, 03H ;Fila 3
     MOV DL, 25H ;Columna 37 Dec
     INT 10H
     
     LINEA4:
     MOV AH, 02H ;Salida del caracter
     MOV DL, 2AH ;Codigo ascii del caracter (*) 42 Dec
     INT 21H
     LOOP LINEA4
      
;------LINEA CINCO------  
     MOV CX, 9  ;Cantidad de * a imprimir
        
     MOV AH, 02H ;Posicionar el Cursor
     MOV DH, 04H ;Fila 4
     MOV DL, 24H  ;Columna 36 Dec
     INT 10H 
     
     LINEA5:
     MOV AH, 02H ;Salida del caracter
     MOV DL, 2AH  ;Codigo ascii del caracter (*) 42 Dec
     INT 21H
     LOOP LINEA5

     RET
     MAIN ENDP
 CODIGO ENDS
 END MAIN
     