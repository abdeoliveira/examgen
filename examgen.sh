#!/bin/bash
#================================
NUM_EXAMS=$1
NUM_ALTS=5
export EXAMGEN_LOCALE='ptbr' 
#================================
set -e

if [[ $1 == "" ]];then
	echo "USAGE: genexams.sh <num_exams> <num_alternatives>"
	echo "<num_alternatives> = 5 if none is given."
	exit 1
fi
if [[ $2 != "" ]];then
	NUM_ALTS=$2
fi
NOW=$(date +"%Y.%m.%d-%H.%M.%S")
if [[ -d ./session ]];then
	BUILD=$(cat ./session/build)
	rm ./session/*.pdf && rm ./session/*.log && rm ./session/*.aux
	if [[ $1 != 1 ]]; then
        	mv session ./.session_$BUILD
	else
		rm -r session
	fi
fi
cd ./src && ruby main.rb $NUM_EXAMS $NUM_ALTS $NOW && echo $NOW > ../session/build
cd ../session && ./script && gio open output.pdf

