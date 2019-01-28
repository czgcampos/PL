converterGPXtoKML:  converterGPXtoKML.fl
					flex converterGPXtoKML.fl
					gcc -o converterGPXtoKML lex.yy.c -ll

execute:			converterGPXtoKML
					./converterGPXtoKML *.gpx

install:			converterGPXtoKML
					sudo cp converterGPXtoKML /usr/local/bin
					rm lex.yy.c converterGPXtoKML