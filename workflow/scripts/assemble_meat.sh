#!/bin/bash
#SBATCH -J default		#Job name

#reassign variable names

fwd_list=$1
bwd_list=$2
meth=$3
ass_thresh=$4
threads=$5
spm=$6
spades_path=$7

#reset timer
SECONDS=0

if [[ "$meth" == "metaspades" ]]
then
	${spades_path}/spades.py \
		-o "results/assembled_seqs" \
		--meta \
		-1 ${1} \
		-2 ${2} \
		-t ${5} -m ${6}
else
	echo "Assembly method $meth not valid"
fi

sleep 10
dir=$(ls -A results/assembled_seqs/)

until [[ dir -ne "" ]]
do
	sleep 10
	echo "working..."
done 


