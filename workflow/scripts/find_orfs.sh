#!/bin/bash

ass_contigs=$1
prod_path=$2
manifest=$3
sample=$4
samp_doc=$5

#reset timer
start=$SECONDS

if [ ! -d "results/04-protein_seqs" ]
then
	mkdir results/04-protein_seqs
fi

prod_meth="$(grep "    GENE PRED :" $samp_doc | sed 's/^.*: //')"s
prod_meth="prodigal:meta_comp"

if [[ "$prod_meth" == "prodigal:meta_comp" ]]
then
	${prod_path}/prodigal \
		-i ${ass_contigs} \
		-o results/04-protein_seqs/${sample}_prot_seqs/prodigal_output.gff \
		-f gff \
		-a results/04-protein_seqs/${sample}_prot_seqs/protein_translations.faa \
		-p "meta" \
		-c
elif [[ "$prod_meth" == "prodigal:meta" ]]
then
        ${prod_path}/prodigal \
                -i ${ass_contigs} \
                -o results/04-protein_seqs/${sample}_prot_seqs/prodigal_output.gff \
                -f gff \
                -a results/04-protein_seqs/${sample}_prot_seqs/protein_translations.faa \
                -p "meta" \
else
	echo "Prodigal method $prod_meth not valid"
fi
              
duration=$(( SECONDS - start ))

echo "time(sec):"; echo $duration

