#!/bin/bash

BODY=`cat text.txt`
DIR="html/files"
HTML="<html>
	<head>
		<title>Dummy page</title>
	</head>
	<body>
		$BODY
	</body>
</html>"

mkdir -p "$DIR"
echo "$HTML" > "$DIR/index.html"
ln -f "$DIR/index.html" `expr match "$DIR" '\(.*/\)'`"index.html"
ln -fs "$DIR/index.html" "index.lnk"
chmod u=rw,g=rw,o=x "$DIR/index.html"
