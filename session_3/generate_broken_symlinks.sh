#!/bin/bash

work_dir=${1:-`pwd`}
mkdir -p $work_dir || exit 1

touch "$work_dir/not_ver.file"

for i in `seq 0 10`; do
	touch "$work_dir/ver$i.file"
done

for fname in "$work_dir"/*.file; do
	ln -sf "$fname" "${fname%%.file}.lnk"
	rm "$fname"
done
