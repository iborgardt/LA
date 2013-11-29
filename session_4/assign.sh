#!/bin/bash

names='names'
tasks='tasks'
workers='workers.lst'
work_table='work.table'

> "$workers"
> "$work_table"
i=1

cat "$names" | sort -u | while read name; do

	echo "[$i]: $name [${#name}]" >> $workers
	((i++))
done

echo "Current tasks:"
cat "$tasks" | tr ' ' '_'

exec 3>&1
exec > "$work_table"

echo "Assigned tasks:"
paste -d'=' $names $tasks
echo "Date: `date +%m/%d/%Y` Time: `date +%H:%M:%S`"
exec 1>&3 3>&-

echo "Assigning: DONE"
echo "Worker list: $workers"
echo "Assigned tasks table: $work_table"

