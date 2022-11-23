#!/bin/bash

prot_seqs=$1
meth=$2
nuc_id=$3
overlap=$4

start=$SECONDS

#mkdir results/clustered_seqs

if [[ "$meth" == "easy_cluster" ]]
then
	mmseqs easy-cluster \
		${prot_seqs} \
		results/clustered_seqs/clust \
		results/cluster_tmp \
		--min-seq-id ${nuc_id} \
		-c ${overlap} \
		--cov-mode 1
else
	echo "clustering method not supported"
fi

duration=$(( SECONDS - start ))
echo " "
echo "time(sec):"
echo $duration
