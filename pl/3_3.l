%{
#include <stdio.h>

int sub=0;
int soma=0;
int nr=0;
%}
%x SOMA 

%%

\+		{BEGIN SOMA;}
<SOMA> 	{
			\+		BEGIN INITIAL;
			[0-9]+	{	sub+=atoi(yytext);
						soma+=atoi(yytext);
						nr++;
					}
			=		{	printf("Subtotal: %d\n",sub);
						sub=0;
					}
			(.|\n)	{;}
		}
(.|\n)	{;}

%%

int main(){
	yylex();
	printf("Li %d numero que somam %d.\n",nr,soma);
	return 0;
}