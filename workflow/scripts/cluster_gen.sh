#!/bin/bash

prot_seqs=$1
meth=$2
nuc_id=$3
overlap=$4
db=$5
sample=$6

start=$SECONDS

#mkdir results/05-clustered_seqs

if [[ "$meth" == "easy_cluster" ]]
then
	mmseqs easy-cluster \
		${prot_seqs} \
		results/05-clustered_seqs/${sample} \
		results/05-clustered_seqs/${sample}_cluster/cluster_tmp \
		--min-seq-id ${nuc_id} \
		-c ${overlap} \
		--cov-mode 1
	mv results/05-clustered_seqs/${sample}* results/05-clustered_seqs/${sample}_cluster
else
	echo "clustering method not supported"
fi



duration=$(( SECONDS - start ))
echo " "
echo "time(sec):"
echo $duration
