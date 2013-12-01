#!/bin/bash

: << COMMENTARY
	This script reads the names and tasks from 
	files $names and $tasks, after this it assigns
	in the $work_table task to worker and puts 
	in the $workers enumerated list of all the names
	ordered by alphabet.
	$workers and $work_table are specified in the settings.conf file.
COMMENTARY

source settings.conf
names='names'
tasks='tasks'

> "$work_table"
i=1

cat "$names" | sort -u | while read name; do

	echo "[$i]: $name [${#name}]"
	((i++))
done > "$workers"

echo "Current tasks:"
cat "$tasks" | tr ' ' '_'

exec 3>&1
exec > "$work_table"

echo "Assigned tasks:"
paste -d'=' "$names" "$tasks"
echo "Date: `date +%m/%d/%Y` Time: `date +%H:%M:%S`"
exec 1>&3 3>&-

echo "Assigning: DONE"
echo "Worker list: $workers"
echo "Assigned tasks table: $work_table"

