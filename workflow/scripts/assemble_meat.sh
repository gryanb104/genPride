#!/bin/bash
#SBATCH -J metaSpades_${14}	#Job name
#SBATCH	-n ${9}			#number of cpus
#SBATCH -N ${8}			#number of nodes
#SBATCH --mem=${10}
#SBATCH -t ${11}		#runtime
#SBATCH -p ${12}		#partition
#SBATCH --${13}			#exclusive need?

#reassign variable names

fwd_list=$1
bwd_list=$2
meth=$3
ass_thresh=$4
threads=$5
spm=$6
spades_path=$7
nodes=$8
cpus=$9
memory=$10
runtime=$11
partition=$12
ex_need=$13
name=$14

#reset timer
SECONDS=0

if [[ "$meth" == "metaspades" ]]
then
	${spades_path}/spades.py \
		-o "results/assembled_seqs" \
		--meta \
		-1 ${1} \
		-2 ${2} \
		-t ${threads} -m ${spm}
else
	echo "Assembly method $meth not valid"
fi




