;@utor Gutierrez Loaeza Carlos de Jesus
    
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
    COLX DB 29H ;Posicion de la columna
      FILY DB 0 ; Posicion de la fila
      ACUM DB 1 ;Cantidad de Asteriscos Inicial
      COLX2 DB 25H ;Posicion de la columna Triangulo 2
      FILY2 DB 4 ; Posicion de la fila Triangulo 2
      ACUM2 DB 9 ;Cantidad de Asteriscos Inicial Triangulo 2
      cad1 db 'ROMBO UTILIZANDO CMP Y JNE',10,13,'$'
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
        
        MOV CX,5 ;Se repetir? 12 veces la comparacion
        CMP CL,0  ;Se realiza la cdomparacion
        segunCMP:   ; se Inicia el CMP 
        MOV BX,CX ;almacenamos el valor del registro en otro
            MOV CL,ACUM ; le asignamos al registro el valor del acum
            CMP CL,0  ;comparamos de nuevo
            segunCMP2: ;inicia el segundo CMP
                MOV AH,2H  ;Indicamos el codigo del *
                MOV DL,2AH
                INT 21H 
                DEC CL ;Decrementamos el valor del registro
                JNE segunCMP2 ; Llamamos de nuevo el segundo CMP
                              ;dependiedo del JNE
            MOV CX,BX ;Recuperamos el valor del registro
            ADD ACUM,2 ;aumentamos la cantidad de asteriscos a imprimir
            INC FILY  ;Incrementamos el valor de la fila
            SUB COLX,1 ;Decrementamos el valor de la columna
            CURSOR COLX,FILY;Llamamos nuevamente el m?todo
                                 ;con las nuevas posiciones del cursor
            DEC CL ; Decrementamos el Valor del registro
            JNE segunCMP   ;LLamamos el primer CMP dependiedo del JNE     
            
        CURSOR COLX2,FILY2 ; llamada al m?todo de posicion del cursor
                           ;Segundo triangulo
         
                           MOV CX,5 ;Se repetir? 12 veces la comparacion
         CMP CL,0 ;Se realiza la cdomparacion
         segunCMP12:     ; se Inicia el CMP 
        MOV BX,CX ;almacenamos el valor del registro en otro
            MOV CL,ACUM2  ; le asignamos al registro el valor del acum
            CMP CL,0 ;comparamos de nuevo
            segunCMP22: ;inicia el segundo CMP
                MOV AH,2H ;Indicamos el codigo del *
                MOV DL,2AH
                INT 21H 
                DEC CL ;Decrementamos el valor del registro
                JNE segunCMP22; Llamamos de nuevo el segundo CMP
                              ;dependiedo del JNE
                MOV CX,BX ;Recuperamos el valor del registro
                SUB ACUM2,2 ;Decrementamos el valor de la cantidad
                            ; de * a imprimir
                INC FILY2   ;Incrementamos el valor de la fila
                ADD COLX2,1 ;Incrementamos el valor de la columna
                CURSOR COLX2,FILY2 ;Llamamos el metodo con los nuevos 
                                   ;valores para el cursor

            DEC CL ; Decrementamos el Valor del registro
            JNE segunCMP12  ;LLamamos el primer CMP dependiedo del JNE  
        RET
    PRINC ENDP

CODE ENDS
END PRINC

                   