.286
pila segment stack
db 32 dup ('stack_')
pila ends

data segment
var dw '$'
data ends

code segment
    MAIN proc far
assume cs:code, ds:data, ss:pila
push ds
push 0

mov ax,data
mov ds,ax
;Establecer modo video (Texto)
mov ah,00h
mov al,03h
int 10H
;Posicionar el cursor
mov cx,80
mov ah,02h
mov dh,0
mov dl,0
mov bx,1
;arriba
ciclo1:
mov ah,02h
int 10H
;Escribir caracter
mov ah,0Ah
mov al,2Ah ;codigo del caracter a escribir(*)
mov var,cx
mov cx,bx
int 10H

add dl,1
mov cx,var
loop ciclo1

mov cx,25
mov ah,02h
mov dh,0
mov dl,79
mov bx,1
;derecha
ciclo2:
mov ah,02h
int 10H

mov ah,0Ah
mov al,2Ah
mov var,cx
mov cx,bx
int 10H

add dh,1
mov cx,var
loop ciclo2

mov cx,80
mov ah,02h
mov dh,24
mov dl,79
mov bx,1
;Abajo
ciclo3:
mov ah,02h
int 10H

mov ah,0Ah
mov al,2Ah
mov var,cx
mov cx,bx
int 10H

sub dl,1
mov cx,var
loop ciclo3


mov cx,79
mov ah,02h
mov dh,23
mov dl,0
mov bx,1
;izquierda
ciclo4:
mov ah,02h
int 10H

mov ah,0Ah
mov al,2Ah
mov var,cx
mov cx,bx
int 10H

sub dh,1
mov cx,var
loop ciclo4

ret
main endp
code ends
end main