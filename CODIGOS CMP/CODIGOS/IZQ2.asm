;@utor Gutierrez Loaeza Carlos de Jesus
;Piramide hacia la Izquierda

PILA SEGMENT STACK
    DB 32 DUP ('STACK---')
PILA ENDS
DATA SEGMENT
    FIL DB 4 ; Posicion de la fila
    COL DB 30 ;Posicion de la columna
    cad1 db 'PIRAMIDE UTILIZANDO LOOP',10,13,'$'
    VAR3 DB 0 ;Variable Auxiliar
DATA ENDS
CODE SEGMENT
    PRINCIPAL PROC FAR
    ASSUME CS:CODE,DS:DATA,SS:PILA
     PUSH DS
     PUSH 0
     MOV AX,DATA
     MOV DS,AX

     MOV AH,09  ; Impresion del titulo
        MOV DX, OFFSET cad1
        INT 21H
        
     MOV CX,5 ;Se repetir? 5 veces la comparacion
     MOV SI,1 ;Cantidad de Asteriscos Inicial
    CMP CX,0 ;Se realiza la cdomparacion
     segunCMP: ; se Inicia el CMP
     MOV AH,02H ;Posicionamos el cursor 
     MOV BH,00H
     MOV DH,FIL
     MOV DL,COL
     INT 10H

     MOV DI,CX ;almacenamos el valor del registro en otro
     MOV CX,SI ; le asignamos al registro el valor del SI
     MOV VAR3,DH ;almacenamos en la var. aux. el valor del registro
     CMP CX,0 ;comparamos el registro con el nuevo valor
     segunCMP2:;inicia el segundo CMP
     MOV AH,02H
     MOV BH,00H
     MOV DL,COL
     INT 10H

     MOV AH,02H ;Indicamos el codigo del *
     MOV DL,2AH
     INT 21H

     MOV DL,10 ;Saltamos Linea para imprimir los * vertical
     INT 21H

     INC DH
     DEC CX ;Decrementamos el valor del registro
     JNE segunCMP2 ; Llamamos de nuevo el segundo CMP
                              ;dependiedo del JNE

     MOV DH,VAR3 ;Recuperamos el valor del registro
     DEC FIL ;Decrementamos el valor de la fila
     INC COL ;Incrementamos el valor de la columna
     MOV CX,DI ;Recuperamos el valor del registro
     ADD SI,2 ;Incrementamos el valor de los *
     DEC CX ;Decrementamos el valor del registro
     JNE segunCMP ; Llamamos de nuevo el primer CMP
                              ;dependiedo del JNE

    MOV AX,4C00H ;Terminaci?n del programa
    INT 21H
    
    PRINCIPAL ENDP
CODE ENDS
END PRINCIPAL