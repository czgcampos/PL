%{
float TABID[26];
%}
%union{
	float val;
	char c;
	char* code;
}
%token <val>NUM
%token <c>ID
%type <code>atrib exps exp termo fator

%%

prg: exps				{printf("pushn 26\nstart\n%s stop\n",$1);}
   ;

exps: atrib				{$$=$1;}
	| exps ';' atrib	{asprintf(&$$,"%s %s",$1,$3;}
	;

atrib: ID '=' exps		{asprintf(&$$,"%s storeg %s\n",$3,TABID[$1-'a'];}
	 ;

exp: termo				{$$=$1;}
   | exp '+' termo		{asprintf(&$$,"%s %s fadd\n",$1,$3;}
   | exp '-' termo		{asprintf(&$$,"%s %s fsub\n",$1,$3;}
   ;

termo: fator			{$$=$1;}
	 | termo '*' fator	{asprintf(&$$,"%s %s fmul\n",$1,$3;}
	 | termo '/' fator	{asprintf(&$$,"%s %s fdiv\n",$1,$3;}
	 ;

fator: NUM				{asprintf(&$$,"pushf %f\n",$1);}
	 | ID 				{asprintf(&$$,"pushg %d\n",TABID[$1-'a']);}
	 | '(' exp ')'		{$$=$2;}
	 ;

%%

#include "lex.yy.c"

int yyerror(char* s){
	printf("%s",s);
}
int main(){
	for(int i=0;i<26;i++)
		TAB[i]=i;
	yyparse();
	return 0;
}