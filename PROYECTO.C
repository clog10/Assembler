//Gutierrez Loaeza Carlos de Jesus
//Proyecto Lenguajes de Interfaz
//Simulacion de piano

//Importacion de librerias primordiales
#include<stdio.h>
#include<stdlib.h>

//Declarando variables de texto que se mostrarán
//en la ejecución del programa
char titulo[20]="Piano Musical$";
char notaDo[35]="Nota Do presionada$";
char NotaRe[35]="Nota Re presionada$";
char NotaMi[35]="Nota Mi presionada$";
char NotaFa[35]="Nota Fa presionada$";
char NotaSol[35]="Nota Sol presionada$";
char NotaLa[35]="Nota La presionada$";
char NotaSi[35]="Nota Si presionada$";
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
		//Enciende el altavoz
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
		mov bh,73h//color de la pantalla
		mov ch,a//linea donde comienza la ventana de texto 
		mov cl,b//columna donde comienza la ventana de texto 
		mov dh,a1//linea donde acaba la ventana de texto
		mov dl,b1//columna donde acaba la ventana de texto
		int 10H
	}
}

//Metodo que posiciona el cursor en la pantalla
//conforme a las coordenadas dadas
void posicionar_cursor(char fila,char columna){
	asm{
		mov ah,02h
		mov bh,00//pagina de video
		mov dh,fila//linea donde sutuaremos el cursor
		mov dl,columna//columna donde situaremos el cursor
		int 10h
	}
}

//Metodo que imprime Texto en la pantalla
//Este método descompone el arreglo de caracteres
//e imprime caracter por caracter y se lo pasa a 
//codigo ensamblador que no puede recibir cadenas
void printText(char texto[]){
	int j;	
	char letra;
	j=0;
	while(texto[j]!='$'){
		letra = texto[j];
		asm{
			mov ah,02h
			//codigo ASCII que se imprimirá
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
}

//Metodo que limpia la pantalla en donde se imprime
//el texto cada que se genera una pulsacion del teclado	
void limpiar(char a, char b,char a1, char b1){
	asm{
		mov ax, 0600h
		mov bh,30h
		mov cl,b
		mov ch,a
	
		mov dl,b1
		mov dh,a1
		int 10H
	}}
	
//Metodo que termina la ejecución del programa
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
	cls();
	ventana(10,25,12,35);
	posicionar_cursor(11,26);
	printText(titulo);

	REPETIR:

	retardo();
	silence();

	asm {
		//Interrupcion para controlar el teclado
		MOV AX,0
		//Obtener el estado del teclado
		MOV AH,01H
		INT 16H
		JZ REPETIR
		//Obtener pulsación del teclado
		//para compararla y poder emitir
		//sonidos 
		MOV AH,00H
		INT 16H
		//Comparaciones con la tecla pulsada
		//para comparar y emitir el sonido
		//correspondiente

		CMP AL,71H//Tecla  presionada
		JZ  C5//Llamada al sonido a escuchar
		CMP AL,32H//Tecla  presionada
		JZ DB5//Llamada al sonido a escuchar
		CMP AL,77H//Tecla  presionada
    	JZ D5//Llamada al sonido a escuchar
    	CMP AL,33H//Tecla  presionada
    	JZ EB5//Llamada al sonido a escuchar
    	CMP AL,65H//Tecla  presionada
    	JZ E5//Llamada al sonido a escuchar
    	CMP AL,72H//Tecla  presionada
    	JZ F5//Llamada al sonido a escuchar
    	CMP AL,35H//Tecla  presionada
    	JZ GB5//Llamada al sonido a escuchar
    	CMP AL,74H//Tecla  presionada
    	JZ G5//Llamada al sonido a escuchar
    	CMP AL,36H//Tecla  presionada
    	JZ AB5//Llamada al sonido a escuchar
    	CMP AL,79H//Tecla  presionada
    	JZ A5//Llamada al sonido a escuchar
    	CMP AL,37H//Tecla  presionada
    	JZ BB5//Llamada al sonido a escuchar
    	CMP AL,75H//Tecla  presionada
    	JZ B5//Llamada al sonido a escuchar
    	CMP AL,7AH//Tecla  presionada
		JZ  C4//Llamada al sonido a escuchar
		CMP AL,73H//Tecla  presionada
		JZ DB4//Llamada al sonido a escuchar
		CMP AL,78H//Tecla  presionada
    	JZ D4//Llamada al sonido a escuchar
    	CMP AL,64H//Tecla  presionada
    	JZ EB4//Llamada al sonido a escuchar
    	CMP AL,63H//Tecla  presionada
    	JZ E4//Llamada al sonido a escuchar
    	CMP AL,76H//Tecla  presionada
    	JZ F4//Llamada al sonido a escuchar
    	CMP AL,67H//Tecla  presionada
    	JZ GB4//Llamada al sonido a escuchar
    	CMP AL,62H//Tecla  presionada
    	JZ G4//Llamada al sonido a escuchar
    	CMP AL,68H//Tecla  presionada
    	JZ AB4//Llamada al sonido a escuchar
    	CMP AL,6EH//Tecla  presionada
    	JZ A4//Llamada al sonido a escuchar
    	CMP AL,6AH//Tecla  presionada
    	JZ BB4//Llamada al sonido a escuchar
    	CMP AL,6DH//Tecla  presionada
    	JZ B4//Llamada al sonido a escuchar
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
