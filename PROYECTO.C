//Gutierrez Loaeza Carlos de Jesus
//Proyecto Lenguajes de Interfaz
//Simulacion de piano

//Importacion de librerias primordiales
#include<stdio.h>
#include<stdlib.h>

//Declarando variables de texto que se mostrarán
//en la ejecución del programa
char titulo[20]="Clic me$";
char notaDo[35]="Clic izquierdo dentro de boton$";
char NotaRe[35]="Clic derecho dentro de boton$";
char clicizqf[35]="Clic izquierdo fuera de boton$";
char clicderf[35]="Clic derecho fuera de boton$";
char sobre[20]="Sobre boton$";
char fuera[20]="Fuera boton$";
int coorx=0;
int coory=0;
char fila=0;
char columna=0;

//metodos
void makeSound(int frequency);
void silence();
void retardo();
void portControl();

//metodo que genera los sonidos 
//frecuency es la variable que tendra
//el codigo de sonido
void makeSound(int frequency) {
	asm {
		//Pasamos al registo el valor para generar sonido
		MOV BX,frequency
		//Movemos el valor bajo al registro
		MOV AL,BL
		//Byte inferior de frecuencia 
		OUT 42H,AL
		//Movemos el valor alto al registro
		MOV AL,BH
		//Byte inferior de frecuencia 
		OUT 42H,AL
		//Leer el modo de puerto actual B (8255)
		IN AL,61H
		//Encienda el altavoz y el temporizador
		OR AL,3
		OUT 61H,AL
	}
}

//
void silence(){
	asm {
		//Leer el modo de puerto actual B (8255)
		IN AL,61H
		//Modo de restauración
		AND AL,0FCH
		OUT 61H,AL
	}
}

void retardo(){
	asm {
		MOV AX,0
		MOV CX,0002H
		MOV DX,0424H
		MOV AH,86H
		INT 15H
	}
}

//Método donde se determina el tamaño de la ventana,
//el color de la pantalla y el texto, desplaza las 
//lineas hacia arriba.
void ventana(char a,char b,char a1,char b1){
	asm{
		mov ax,0600h
		mov bh,73h
		mov ch,a
		mov cl,b
		mov dh,a1
		mov dl,b1
		int 10H
	}
}

//Metodo que posiciona el cursor en la pantalla
//conforme a las coordenadas dadas
void posicionar_cursor(char fila,char columna){
	asm{
		mov ah,02h
		mov bh,00
		mov dh,fila
		mov dl,columna
		int 10h
	}
}

//Metodo que imprime Texto en la pantalla
void printText(char texto[]){
	int j;	
	char letra;
	j=0;
	while(texto[j]!='$'){
		letra = texto[j];
		asm{
			mov ah,02h
			mov dl,letra
			int 21h
		}
		j++;	
	}
}


//Metdodo que apaga el altavoz
void apaga(){
	asm{
		MOV DX, 61H
		IN AL,DX
		AND AL, 0FCH
		OUT DX, AL
	}
}

//Metodo que limpia la pantalla en consola
void cls(){
	asm{
		mov ax,0600h
		mov bh,31h
		mov cx,0000h
		mov dx,184Fh
		int 10h
	}
	ventana(10,25,12,35);
	posicionar_cursor(11,26);
	printText(titulo);
}
	

void fin(){
	apaga();
	asm{
		MOV AH,4CH
    	INT 21H
    	RET
	}
}

void portControl(){
}

void main() {
	
	REPETIR:

	retardo();
	silence();

	asm {
		MOV AX,0
		MOV AH,01H
		INT 16H
		JZ REPETIR

		MOV AH,00H
		INT 16H
		
		CMP AL,71H
		JZ  C5
		CMP AL,32H
		JZ DB5
		CMP AL,77H
    	JZ D5
    	CMP AL,33H
    	JZ EB5
    	CMP AL,65H
    	JZ E5
    	CMP AL,72H
    	JZ F5
    	CMP AL,35H
    	JZ GB5
    	CMP AL,74H
    	JZ G5
    	CMP AL,36H
    	JZ AB5
    	CMP AL,79H
    	JZ A5
    	CMP AL,37H
    	JZ BB5
    	CMP AL,75H
    	JZ B5
    	CMP AL,7AH
		JZ  C4
		CMP AL,73H
		JZ DB4
		CMP AL,78H
    	JZ D4
    	CMP AL,64H
    	JZ EB4
    	CMP AL,63H
    	JZ E4
    	CMP AL,76H
    	JZ F4
    	CMP AL,67H
    	JZ GB4
    	CMP AL,62H
    	JZ G4
    	CMP AL,68H
    	JZ AB4
    	CMP AL,6EH
    	JZ A4
    	CMP AL,6AH
    	JZ BB4
    	CMP AL,6DH
    	JZ B4
	}
	silence();
	asm {
		JMP REPETIR
	}
	C5:
	makeSound(2279);
	asm{
		JMP REPETIR
	}
	DB5:
	makeSound(2151);
	asm{
		JMP REPETIR
	}
	D5:
	makeSound(2030);
	asm{
		JMP REPETIR
	}
	EB5:
	makeSound(1916);
	asm{
		JMP REPETIR
	}
	E5:
	makeSound(1808);
	asm{
		JMP REPETIR
	}
	F5:
	makeSound(1707);
	asm{
		JMP REPETIR
	}
	GB5:
	makeSound(1611);
	asm{
		JMP REPETIR
	}
	G5:
	makeSound(1521);
	asm{
		JMP REPETIR
	}
	AB5:
	makeSound(1435);
	asm{
		JMP REPETIR
	}
	A5:
	makeSound(1355);
	asm{
		JMP REPETIR
	}
	BB5:
	makeSound(1279);
	asm{
		JMP REPETIR
	}
	B5:
	makeSound(1207);
	asm{
		JMP REPETIR
	}
	C4:
	makeSound(4558);
	asm{
		JMP REPETIR
	}
	DB4:
	makeSound(4302);
	asm{
		JMP REPETIR
	}
	D4:
	makeSound(4060);
	asm{
		JMP REPETIR
	}
	EB4:
	makeSound(3832);
	asm{
		JMP REPETIR
	}
	E4:
	makeSound(3617);
	asm{
		JMP REPETIR
	}
	F4:
	makeSound(3414);
	asm{
		JMP REPETIR
	}
	GB4:
	makeSound(3223);
	asm{
		JMP REPETIR
	}
	G4:
	makeSound(3042);
	asm{
		JMP REPETIR
	}
	AB4:
	makeSound(2871);
	asm{
		JMP REPETIR
	}
	A4:
	makeSound(2710);
	asm{
		JMP REPETIR
	}
	BB4:
	makeSound(2558);
	asm{
		JMP REPETIR
	}
	B4:
	makeSound(2414);
	asm{
		JMP REPETIR
	}
}