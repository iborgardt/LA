#!/bin/bash

function usage(){
	cat << USAGE_MESSAGE
	Usage: prime_numbers.sh [OPTIONS] -n <NUMBER>
	       prime_numbers.sh [OPTIONS] -N <NUMBER>
	NUMBER specifies a range of numbers [2 .. NUMBER] to be checked 
	for prime or not. Must be greater than 1.

	OPTIONS are:
		-f <file> - save results to file
		-h - display help message
		-v - verbose mode
USAGE_MESSAGE
}

function is_prime(){
	for ((i = 2; i <= $1 / 2; i++)); do
		if (($1 % i == 0)); then
			[ $VERBOSE ] && echo -e "\n# $1 is not prime: \
divides evenly by $i"
			return 1
		fi
	done
	return 0
}

function main(){
	[[ $NUMBER -ge 2 ]] && echo -n "2 "
	for ((j = 3; j <= NUMBER; j += 2)); do
		is_prime $j && echo -n "$j "
	done
	echo
	return 0
}

while getopts f:hn:N:v opt; do
	case $opt in
	f) FILE=$OPTARG
	;;
	h) usage
	   exit 1
	;;
	n) NUMBER=$OPTARG
	;;
	N) NUMBER=$OPTARG
	;;
	v) VERBOSE=1
	;;
	esac
done

if [ ! "$NUMBER"  ]; then
	echo "-n NUMBER or -N NUMBER is required option!"
	usage
	exit 2
fi

if [ "$NUMBER" -le 1 ]; then
	echo "NUMBER must be greater than 1"
	exit 3
fi

[ "$FILE" ] && > "$FILE" || { echo "Can't create/write file $FILE"; exit 4; }

[[ "$VERBOSE" && "$FILE" ]] && echo "Saving results in file: $FILE"

[ ! "$FILE" ] && FILE=/dev/null

main "$NUMBER" | tee "$FILE"
