%{
float MEM[26];
%}
%union{
	float val;
	char c;
}
%token <val>NUM
%token <c>ID
%type <val>exp termo fator

%%

exps: ID '=' exp			{MEM[$1-'a']=$3;printf("%f\n",$1);}
	| exps ';' ID '=' exp	{MEM[$3-'a']=$5;printf("%f\n",$3);}
	;

exp: termo					{$$=$1;}
   | exp '+' termo			{$$=$1+$3;}
   | exp '-' termo			{$$=$1-$3;}
   ;

termo: fator				{$$=$1;}
	 | termo '*' fator		{$$=$1*$3;}
	 | termo '/' fator		{$$=$1/$3;}
	 ;

fator: NUM					{$$=$1;}
	 | ID 					{$$=MEM[$1-'a'];}
	 ;

%%

#include "lex.yy.c"

int yyerror(char* s){
	printf("%s",s);
}
int main(){
	yyparse();
	return 0;
}