#!/bin/bash

work_dir=${1:-`pwd`}
mkdir -p $work_dir || exit 1

touch "$work_dir/not_ver.file"
ln -sf "$work_dir/not_ver.file" "$work_dir/not_ver.lnk"

for i in `seq 0 10`; do
	touch "$work_dir/ver$i.file"
done

for fname in "$work_dir"/ver*.file; do
	ln -sf "$fname" "${fname%%.file}.lnk"
	rm "$fname"
done
