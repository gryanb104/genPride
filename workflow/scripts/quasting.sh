#!/bin/bash

quast_path=$1
contigs=$2
quast_meth=$3

mkdir ./results/quast_out

start=$SECONDS

if [[ "$quast_meth" == "metaQUAST" ]]
then
	python $quast_path/metaquast.py $contigs -o ./results/quast_out
else
	echo "Invalid quast method. Check valid options in config/config.yaml."
fi

duration=$(( SECONDS - start ))
echo "time(sec):"
echo -n "$duration"
