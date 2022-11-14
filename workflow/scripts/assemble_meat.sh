#!/bin/bash

#reassign variable names

fwd_list=$1
bwd_list=$2
meth=$3
ass_thresh=$4
threads=$5
spm=$6
spades_path=$7

#reset timer
start=$SECONDS

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

duration=$(( SECONDS - start ))

echo "time(sec):"
echo $duration


