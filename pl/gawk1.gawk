BEGIN {conta=0;FS="::"}
$3	~/Zeferino/ {conta++}
END {print "Encontrei", conta, "Zeferinos"}