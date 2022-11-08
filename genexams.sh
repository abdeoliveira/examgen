#!/bin/bash
#================================
NUM_EXAMS=$1
NUM_ALTS=5
#================================
set -e

if [[ $1 == "" ]];then
	echo "USAGE: genexams.sh <num_exams> <num_alternatives>"
	echo "num_alternatives default = 5 is none is given."
	exit 1
fi
if [[ $2 != "" ]];then
	NUM_ALTS=$2
fi
NOW=$(date +"%Y.%m.%d_%H.%M.%S")
if [[ -d ./session ]];then
	mv session ./session_$NOW
fi
cd ./src && ruby main.rb $NUM_EXAMS $NUM_ALTS
cd ../session && ./script && gio open output.pdf
