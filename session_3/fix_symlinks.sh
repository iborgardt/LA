#!/bin/bash

work_dir=${1:-`pwd`}

for sname in `find $work_dir -type l`; do
	if [ -e "$sname" ]; then
		[ ! -s "$sname" ] && echo "Warning: size of $sname is null!"
	else
		rm "$sname"
	fi
done
