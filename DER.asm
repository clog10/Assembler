.286
PILA SEGMENT STACK
    DB 32 DUP ('STACK---')
PILA ENDS
DATA SEGMENT
    FIL DB 1
    COL DB 20
    VAR3 DB 0
    salto db 10,13,'$'
DATA ENDS
CODE SEGMENT
    PRINCIPAL PROC FAR
    ASSUME CS:CODE,DS:DATA,SS:PILA
     PUSH DS
     PUSH 0
     MOV AX,DATA
     MOV DS,AX

     MOV CX,5
     MOV SI,9
     
    CICLO1:
     MOV AH,02H
     MOV BH,00H
     MOV DH,FIL
     MOV DL,COL
     INT 10H

     MOV DI,CX
     MOV CX,SI
     MOV VAR3,DH

    CICLO2:
     MOV AH,02H
     MOV BH,00H
     MOV DL,COL
     INT 10H

     MOV AH,02H
     MOV DL,2AH
     INT 21H

     MOV DL,10
     INT 21H

     INC DH
    LOOP CICLO2

     MOV DH,VAR3
     INC FIL
     INC COL
     MOV CX,DI
     SUB SI,2
    LOOP CICLO1
    
    mov ah,09
    mov dx, offset salto
    int 21h
    
    MOV AX,4C00H
    INT 21H
    
    PRINCIPAL ENDP
CODE ENDS
END PRINCIPAL