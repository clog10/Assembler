.286

pila segment stack
    db 32 DUP('------')
pila ends

datos segment 
    cad1 db 'Ingresa un numero: ','$'
    cad2 db 'Ingresa otro numero: ','$'
    cad5 db 'Resultado division: ','$'
    salto db 10,13,'$'
    a db 10 dup('$')
    b db 10 dup('$')
    division db 10 dup('$')
datos ends

codigo segment 'code'

MAIN Proc FAR

assume ss:pila, ds:datos, cs:codigo

    push ds
    push 0
    mov ax, datos
    mov ds, ax

    ;limpiar pantalla
    mov ax, 0600h
    mov bh, 47h
    mov cx, 0000h
    mov dx, 184Fh
    int 10h
    
    mov ah, 09
    mov dx, offset cad1
    int 21h
    
    ;leer numero
    mov ah, 01h
    int 21h
    
    mov ah, 09
    mov dx,offset salto;
    int 21h
    sub al,30h
    mov a,al
    
    mov ah, 09
    mov dx, offset cad2
    int 21h

    mov ah, 01h
    int 21h

    mov ah,09
    mov dx, offset salto
    int 21h
    sub al, 30h
    mov b,al
    
   ;division
    aad
    mov al,a
    mov bl,b
    div bl
    mov division,al
    
    ;imprimir division
    add division,30h 
    
        
     mov ah,09
    mov dx, offset salto
    int 21h
    
    mov ah, 09
    mov dx, offset cad5
    int 21h
    sub al, 30h
    
    mov ah, 09h
    mov dx, offset division
    int 21h
    
     jmp salir
    
    salir:
    .exit
    
    ret
    main ENDP
codigo ends
end main


   
   
    