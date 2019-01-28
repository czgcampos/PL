%{
int linha=1;
int coluna=1;
%}

%%

[ \t] 			;
(\+|\-)?[0-9]+	{printf("INT(\"%s\",l=%d,c=%d)\n",yytext,linha,coluna);coluna+=strlen(yytext);}
\n				{linha++; coluna=1;}
.				coluna++;

%%