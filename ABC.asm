.286
pila segment stack
db 32 DUP('stack--')
pila ends

datos segment
    
ends datos

codigo segment 'code'
    Main proc FAR
    assume ss: pila, ds: datos, cs: codigo
    
    mov cx,26
    
    mov ah,2
    mov dl,65
    
    L1:
    int 21h
    inc dl
    dec cx
    jnz L1

    mov dh, 1h
    mov dl, 0h
    int 10h
    
    mov cx,26
    
    mov ah,2
    mov dl,90
    
    L3:
    int 21h
    dec dl
    dec cx
    jnz L3
    
    mov ah,4ch
    int 21h
    
    ret
    main endp
codigo ends
end main
