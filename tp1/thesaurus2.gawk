#!/usr/bin/gawk -f

BEGIN {
	FS=":"; RS="\n"; m=0; n=0; o=0; l=0;
	printf "<html>\n<head>\n\t<meta charset='utf-8'/>\n\t</head>\n\t<body>\n\t<h1>Thesaurus</h1>\n\t<table border='1'>\n\t\n" > "thesaurus.html";
	printf "<html>\n<head>\n\t<meta charset='utf-8'/>\n\t</head>\n\t<body>\n\t<table border='1'>\n\t<tr><th>Dominios</th><th>Ficheiro</th></tr>\n" > "dominios.html";
	printf "<html>\n<head>\n\t<meta charset='utf-8'/>\n\t</head>\n\t<body>\n\t<table border='1'>\n\t<tr><th>Relacao</th><th>Inversa</th><th>Ficheiro</th></tr>\n" > "inversas.html";
	printf "<html>\n<head>\n\t<meta charset='utf-8'/>\n\t</head>\n\t<body>\n\t<table border='1'>\n\t<tr><th>Relacoes</th><th>Ficheiro</th></tr>\n" > "relacoes.html";
	printf "<html>\n<head>\n\t<meta charset='utf-8'/>\n\t</head>\n\t<body>\n\t<table border='1'>\n\t<tr><th>Entidade1</th><th>Relação</th><th>Entidade2</th><th>Dominio</th><th>Ficheiro</th></tr>\n" > "triplos.html";
}

$1 ~/\s*%dom\s*/ {
	dominio=$2;
	ficheiroDom=$2.html;
	ficheirosDom[m++]=ficheiroDom;
	printf "<html>\n<head>\n\t<meta charset='utf-8'/>\n\t</head>\n\t<body>\n\t<h2>%s</h2>\n\t<table border='1'>\n\t<tr><th>Entidade1</th><th>Relação</th><th>Entidade2</th><th>Ficheiro</th></tr>\n", dominios[$2] > ficheiroDom;
	printf "\t\t<tr><td><a href=\"%s\">%s</a></td><td>%s</td></tr>\n", ficheiroDom, $2, FILENAME > "dominios.html";
}
$1 ~/\s*%inv\s*/ {
	gsub(" ","",$2);
	gsub(" ","",$3);
	inversas[o++]=$3;
	relacoesComInv[l++]=$2;
	printf "\t\t<tr><td>%s</td><td>%s</td><td>%s</td></tr>\n", $2, $3, FILENAME > "inversas.html";
}
$1 ~/\s*%THE\s*/ {
	n=0;
	if(match($1,/</))
		for(i=2;i<=NF;i++){
			if(match($i,/</)){
				split($i,termos,"<");
				gsub(" ","",termos[1]);
				printf "\t\t<tr><td>%s</td><td>%s</td></tr>\n", termos[1], FILENAME > "relacoes.html";
				relacoes[n++]=termos[1];
			}else{
				gsub(" ","",$i);
				printf "\t\t<tr><td>%s</td><td>%s</td></tr>\n", $i, FILENAME > "relacoes.html";
				relacoes[n++]=$i;
			}
		}
	else{
		gsub(" ","",$2);
		printf "\t\t<tr><td>%s</td><td>%s</td></tr>\n", $2, FILENAME > "relacoes.html";
		relacoes[n++]=$2;
	}
}
$1 ~/\s*#/ {next}
$1 !~/\s*%\s*/ {
	for(i=0;i<n;i++){
		split($(i+2),termos,"|");
		for(t in termos){
			termo1=$1; termo2=termos[t];
			gsub(" ","_",termo1);
			gsub(" ","_",termo2);
			printf "\t\t<tr><td><a href=https://pt.wikipedia.org/wiki/%s>%s</a></td><td>%s</td><td><a href=https://pt.wikipedia.org/wiki/%s>%s</a></td><td>%s</td><td>%s</td></tr>\n", termo1, $1, relacoes[i], termo2, termos[t], dominio, FILENAME > "triplos.html";
			printf "\t\t<tr><td><a href=https://pt.wikipedia.org/wiki/%s>%s</a></td><td>%s</td><td><a href=https://pt.wikipedia.org/wiki/%s>%s</a></td><td>%s</td></tr>\n", termo1, $1, relacoes[i], termo2, termos[t], FILENAME > ficheiroDom;
			for(j=0;j<=l;j++){
				if(relacoesComInv[j]==relacoes[i]){
					printf "\t\t<tr><td><a href=https://pt.wikipedia.org/wiki/%s>%s</a></td><td>%s</td><td><a href=https://pt.wikipedia.org/wiki/%s>%s</a></td><td>%s</td><td>%s</td></tr>\n", termo2, termos[t], inversas[j], termo1, $1, dominio, FILENAME > "triplos.html";
					printf "\t\t<tr><td><a href=https://pt.wikipedia.org/wiki/%s>%s</a></td><td>%s</td><td><a href=https://pt.wikipedia.org/wiki/%s>%s</a></td><td>%s</td></tr>\n", termo2, termos[t], inversas[j], termo1, $1, FILENAME > ficheiroDom;
				}
			}
		}
	}
}

END {
	printf "\t\t<tr><th><a href=\"dominios.html\">Dominios</a></tr></th>\n" > "thesaurus.html";
	printf "\t\t<tr><th><a href=\"inversas.html\">Inversas</a></tr></th>\n" > "thesaurus.html";
	printf "\t\t<tr><th><a href=\"relacoes.html\">Relacoes</a></tr></th>\n" > "thesaurus.html";
	printf "\t\t<tr><th><a href=\"triplos.html\">Triplos</a></tr></th>\n" > "thesaurus.html";
	for(f in ficheirosDom)
		printf "\t</table>\n\t</body>\n</html>" > ficheirosDom[f];
	printf "\t</table>\n\t</body>\n</html>" > "dominios.html";
	printf "\t</table>\n\t</body>\n</html>" > "inversas.html";
	printf "\t</table>\n\t</body>\n</html>" > "relacoes.html";
	printf "\t</table>\n\t</body>\n</html>" > "triplos.html";
	printf "\t</table>\n\t</body>\n</html>" > "thesaurus.html";
}