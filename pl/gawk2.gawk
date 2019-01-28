BEGIN {
	FS="::";print "<html>\n\t<body>\n\t<table border='1'>\n";
	print "<tr><th>Inquirido</th><th>Pai</th><th>Mae</th></tr>"
}

	{print "<tr><td>",$3,"</td><td>",$4,"</td><td>",$5,"</td></tr>"}

END {print "</table></body></html>>"}