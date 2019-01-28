BEGIN{RS="(HREF|href)";FS="\""}
	$0 ~/^="[A-Za-z0-9./#\?:~]+"/ {print $2} 
END{}