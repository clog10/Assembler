.286

pila segment stack 
    db 32 DUP('stack----')
pila ends

datos segment 
    let1 db 'Introduce un numero: ','$'
    let3 db 'Son iguales a y b',10,13,'$'
    let4 db 'Son iguales a y c',10,13,'$'
    let5 db 'Son iguales b y c',10,13,'$'
    let6 db 'Son iguales todos',10,13,'$'
    salto db 10,13,'$'
    let2 db 'El mayor es: ','$'
    a db 10 dup('$')
    b db 10 dup('$')
    c db 10 dup('$')
 
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
    mov dx, offset let1;
    int 21h

    mov ah, 01h
    int 21h

    mov ah, 09
    mov dx,offset salto;
    int 21h

    mov a, al

    mov ah, 09
    ;imprimimos el msj1
    int 21h
    
    mov ah, 01h
    int 21h

    mov ah, 09
    mov dx, offset salto
    int 21h

    mov b, al

    mov ah,09
    mov dx, offset let1
    int 21h

    mov ah, 01h
    int 21h

    mov ah,09
    mov dx,offset salto
    int 21h

    mov c, al
    
    mov ah,a
    mov al,b
    cmp ah,al
    je igualab
    ja compara13
    
    compara13:
    mov al,c
    cmp ah,al
    je igualac
    ja mayor1
    
    compara23:
    mov ah,b
    mov al,c
    cmp ah,al
    ja mayor2
    jmp mayor3
    
    
    igualab:
    mov ah,09
    mov dx, offset let3
    int 21h
    jmp compara13
    
    igualac:
    mov ah,09
    mov dx,offset let4
    int 21h
    jmp compara23
    
    igualbc:
    mov ah,09
    mov dx,offset let4
    int 21h
    
    mayor1:
    mov ah,09
    mov dx,offset let2
    int 21h
    
    mov ah,09
    mov dx, offset a
    int 21h
    jmp salir
    
    mayor2:
    mov ah,09
    mov dx,offset let2
    int 21h
    
    mov ah,09
    mov dx,offset b
    int 21h
    jmp salir 
    
    mayor3:
    mov ah,09
    mov dx,offset let2
    int 21h
    
    mov ah,09
    mov dx,offset c
    int 21h
    jmp salir 
    
    salir:
    .exit
    
    ret
    main ENDP
codigo ENDS
end main

    
    

    
