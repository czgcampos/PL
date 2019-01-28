%{
#include "tokens.h"
%}

%%

[ \t\n] ;
\+		return SOMA;
\-		return SUB;
\*		return MUL;
\(		return ABRE;
\)		return FECHA;
[0-9]+	return INT;
.		return ERRO;

%%