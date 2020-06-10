//Gutierrez Loaeza Carlos de Jesus
//Proyecto Lenguajes de Interfaz
//PAINT

//Importacion de librerias primordiales
#include<stdio.h>
#include<stdlib.h>
#include<dos.h>
#include<conio.h>

int OLDCOLOR=0;
int NEWCOLOR=0;
int OLDPOSX=0;
int OLDPOSY=0;
int estado=0;


void main(){
	asm{
	    //INICIALIZAR MODO GRAFICO DE VIDEO
        MOV AH, 00
        MOV AL, 0013H
        INT 10H

        //INICIALIZA INTERRUPCION DEL MOUSE
        XOR AX,AX
        INT 33H
        
    }
    //tamaño ventana
    CICLO_PALETA:
        asm{
        
        MOV AH, 0CH//ESCRIBIR PUNTO O PIXEL
        MOV AL, 0FH//OBTENER MODO DE VIDEO ACTUAL
        INT 10H

        INC DX
        CMP DX,480 ;//PINTADO VERTICAL
        JNE CICLO_PALETA

        MOV DX, 00
        INC CX
        CMP CX, 640 ;//PINTADO HORIZONTAL 
        JNE CICLO_PALETA
        }


        //REVISAR POSICIONES DEL MOUSE Y ESTADO DE 
        //LOS BOTONES
        MOUSE:
            asm{
        MOV AX, 03H
        INT 33H
    
        MOV AX,01H
        INT 33H
        
        SHR CX,01H //AJUSTA MODO DE VIDEO DE 12H A 13H
        CMP BX, 01H //CLIC IZQUIERDO, SI LO PRESIONA
        JE UPDATE
        CMP BX, 02H //CLIC DERECHO, SI LO PRESIONA
        JE BORRAR
        JMP UPDATE
            }

        //BORRA CUANDO SE PRESIONA CLIC DERECHO
        BORRAR:
        asm{
                MOV AH, 0CH
                MOV AL, 0FH
                MOV CX, OLDPOSX
                MOV DX, OLDPOSY
                INT 10H
        }
       //PONE EL PIXEL EN LA POSICION ANTERIOR
        UPDATE:
            asm{
                PUSH CX
                PUSH DX

                MOV AX, NEWCOLOR
                MOV CX, OLDPOSX
                MOV CX, OLDPOSY
                
                MOV AH, 0CH
                MOV AL, 03H
                MOV CX, OLDPOSX
                MOV DX, OLDPOSY
                INT 10H

                POP DX
                POP CX
                
                //GUARDAR POSICION ACTUAL DEL MOUSE
                MOV OLDPOSX, CX
                MOV OLDPOSY, DX
                //GUARDAR PIXEL EN POSICION DEL MOUSE
                MOV AH, 0DH
                INT 10H
                
                    MOV OLDCOLOR, AX

                    MOV AX, 0C04H//PIXEL BLANCO PARPADEANTE CON ROJO
                    INT 10H
                    //JMP MOUSE
                    //SI SE OPRIME TECLA ESCAPE
                    
                    MOV AH, 00H
                    INT 16H
                    JMP MOUSE
                    CMP AH, 1BH
                    JE SALIR
            }
                    SALIR:
                        asm{
                        MOV AX,4C00H
                        INT 21H
                        }
                        
	}
