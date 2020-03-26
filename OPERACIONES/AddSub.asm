.286

pila segment stack
    db 32 DUP('------')
pila ends

datos segment 
    cad1 db 'Ingresa un numero: ','$'
    cad2 db 'Ingresa otro numero: ','$'
    cad3 db 'Resultado suma: ','$'
    cad4 db 'Resultado resta: ','$'
    salto db 10,13,'$'
    a db 10 dup('$')
    b db 10 dup('$')
    suma db 10 dup('$')
    resta db 10 dup('$')
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
    
    mov ah, 09
    mov dx, offset cad3
    int 21h
    sub al, 30h
    mov b,al
    
    ;suma
    mov al,b
    add al,a
    mov dl,al
    mov suma,dl
    ;Imprimir suma
    mov dl,suma
    add dl,30h 
    mov ah,02
    int 21h  
    
     ;resta
    
    mov al,a
    sub al,b
    mov dl,al
    mov resta,dl
    
    mov ah,09
    mov dx, offset salto
    int 21h
    
    mov ah, 09
    mov dx, offset cad4
    int 21h
    
    ;sub al, 30h
    ;mov b,al
    ;imprimir resta
    mov dl,resta
    add dl,30h 
    mov ah,02
    int 21h 
    
       
    jmp salir
    
    salir:
    .exit
    
    ret
    main ENDP
codigo ends
end main