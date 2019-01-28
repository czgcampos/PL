BEGIN {FS="::"}
	split($2,data,"-");
	{print $3 > data[1]".html"}
END {}