#!/bin/bash

quast_path=$1
contigs=$2
sample=$3

quast_meth="metaQUAST"

#if [ ! -d "results/03b-quast_out" ]
#then
#	mkdir ./results/03b-quast_out
#fi

start=$SECONDS

if [[ "$quast_meth" == "metaQUAST" ]]
then
	python $quast_path/metaquast.py $contigs -o ./results/03b-quast_out/${sample}_quast
else
	echo "Invalid quast method. Check valid options in config/config.yaml."
fi

duration=$(( SECONDS - start ))
echo "time(sec):"
echo -n "$duration"

