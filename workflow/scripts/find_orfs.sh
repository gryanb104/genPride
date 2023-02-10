#!/bin/bash

ass_contigs=$1
prod_path=$2
prod_meth=$3

#reset timer
start=$SECONDS

mkdir results/protein_seqs

if [[ "$prod_meth" == "meta_comp" ]]
then
	${prod_path}/prodigal \
		-i ${ass_contigs} \
		-o results/protein_seqs/prodigal_output.gff \
		-f gff \
		-a results/protein_seqs/protein_translations.faa \
		-p "meta" \
		-c
elif [[ "$prod_meth" == "meta" ]]
then
        ${prod_path}/prodigal \
                -i ${ass_contigs} \
                -o results/protein_seqs/prodigal_output.gff \
                -f gff \
                -a results/protein_seqs/protein_translations.faa \
                -p "meta" \
else
	echo "Prodigal method $prod_meth not valid"
fi
              
duration=$(( SECONDS - start ))

echo "time(sec):"; echo $duration

