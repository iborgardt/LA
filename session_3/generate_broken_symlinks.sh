#!/bin/bash

touch not_ver.file

for i in `seq 0 10`; do
	touch "ver$i.file"
done

for fname in *.file; do
	ln -s "$fname" "${fname%%.file}.lnk"
	rm "$fname"
done
