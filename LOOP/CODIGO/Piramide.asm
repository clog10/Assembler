 ;@utor Gutierrez Loaeza Carlos de Jesus
 ;Piramide Hacia arriba
    
    CURSOR MACRO VX,VY
        MOV AH, 02H;Posicionar el Cursor
        MOV BH, 0
        MOV DH, VY;Fila
        MOV DL, VX;Columna 
             
        INT 10H
      ENDM

STOCK SEGMENT STACK
    DB 8 DUP ('stack_')
STOCK ENDS
DATAS SEGMENT
      COLX DB 28H ;Posicion de la columna
      FILY DB 0 ; Posicion de la fila
      ACUM DB 1 ;Cantidad de Asteriscos Inicial
      cad1 db 'PIRAMIDE UTILIZANDO LOOP',10,13,'$'
DATAS ENDS
CODE SEGMENT 'CODE'
    ASSUME SS:STOCK,DS:DATAS,CS:CODE
    
    PRINC PROC FAR
        
        PUSH DS
        PUSH 0
        MOV AX, DATAS
        MOV DS,AX

         MOV AH,09  ; Impresion del titulo
        MOV DX, OFFSET cad1
        INT 21H
        
        CURSOR COLX,FILY ; llamada al m?todo de posicion del cursor
        
        MOV CX,5 ;ciclo 1, se repetir? 5 veces
        
        CICLO_1:;INICIO CICLO 1
        PUSH CX ;guardar valor del registro
        MOV CL,ACUM ; ciclo 2, se repetira al inicio una vez,de ahi 
                    ; de 2 en 2
            CICLO_2:;INICIO CICLO 2
                MOV AH,2H ;Indicamos el codigo del *
                MOV DL,2AH
                INT 21H 
            LOOP CICLO_2 ;FIN CICLO 2
            
            ADD ACUM,2 ;aumentamos la cantidad de asteriscos a imprimir
            INC FILY   ;Incrementamos el valor de la fila
            DEC COLX   ;Decrementamos el valor de la columna
            CURSOR COLX,FILY ;Llamamos nuevamente el m?todo
                                 ;con las nuevas posiciones del cursor
            POP CX  ;regresar valor ciclo 1
            LOOP CICLO_1     ;FIN CICLO 1
                    
        RET
    PRINC ENDP

CODE ENDS
END PRINC

                   