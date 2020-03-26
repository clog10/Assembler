;@utor Gutierrez Loaeza Carlos de Jesus
;Piramide hacia abajo
    
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
      COLX DB 24H ;Posicion de la columna
      FILY DB 0 ; Posicion de la fila
      ACUM DB 9 ;Cantidad de Asteriscos Inicial
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
            PUSH CX ;guardar valor del ciclo 1
            MOV CL,ACUM ; ciclo 2, cantidad de asteriscos
            CICLO_2:;INICIO CICLO 2
                MOV AH,2H ;Indicamos el codigo del *
                MOV DL,2AH
                INT 21H 
            LOOP CICLO_2 ;FIN CICLO 2
            
            SUB ACUM,2 ;Decrementamos el valor de la cantidad
                            ; de * a imprimir
            INC FILY  ;Incrementamos el valor de la fila
            INC COLX  ;Incrementamos el valor de la columna
            CURSOR COLX,FILY ;Llamamos el metodo con los nuevos 
                                   ;valores para el cursor

            POP CX  ;decrementar el valor del registro, ciclo 1
        LOOP CICLO_1     ;FIN CICLO 1
                    
        RET
    PRINC ENDP

CODE ENDS
END PRINC

                   