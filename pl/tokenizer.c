#include "tokens.h"
#include <stdio.h>

extern int yylex();

int main(){
	int prox_simb;
	while(prox_simb=yylex()){
		switch(prox_simb){
			case SOMA : 
				printf("SOMA\n");
				break;
			case SUB : 
				printf("SUB\n");
				break;
			case MUL : 
				printf("MUL\n");
				break;
			case ABRE : 
				printf("ABRE\n");
				break;
			case FECHA : 
				printf("FECHA\n");
				break;
			case INT : 
				printf("INT\n");
				break;
			case ERRO : 
				printf("ERRO\n");
				break;
			default:
				printf("Deu erro na main\n");
		}
	}
	return 0;
}