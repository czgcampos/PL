%{
#include <stdio.h>
%}

%%

[9278][0-9]{8} 	{ECHO;printf("\n");}
"<"[^>]*">" 	{ECHO;printf("\n");}
.|\n 			{;}

%%

int yywrap(){
	return 1;
}

int main(){
	yylex();
	return 0;
}