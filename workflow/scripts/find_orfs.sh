#!/bin/bash

ass_contigs=$1
prod_path=$2
prod_meth=$3

#reset timer
start=$SECONDS

mkdir results/protein_seqs

${prod_path}/prodigal \
	-i ${ass_contigs} \
	-o results/protein_seqs/prodigal_output.gff \
	-f gff \
	-a results/protein_seqs/protein_translations.faa \
	-p ${prod_meth} \
	-c

duration=$(( SECONDS - start ))

echo "time(sec):"; echo $duration

