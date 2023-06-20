#!/bin/bash

#reassign variable names

samp_doc=$1
manifest=$2
ass_thresh=$3
threads=$4
spm=$5
spades_path=$6
contig_output=$7

#reset timer
start=$SECONDS

sample="$(grep 'SAMPLE:' $samp_doc | sed 's/^.*: //')"
meth="$(grep '    ASSEMBLY  :' $samp_doc | sed 's/^.*: //')"
fwd_list="$(grep 'FWD READ FILE:' $samp_doc | sed 's/^.*: //')"
bwd_list="$(grep 'REV READ FILE:' $samp_doc | sed 's/^.*: //')"
out_path="$(echo $contig_output | sed 's/contigs.*//')"

if [[ "$meth" == "spades:metaspades" ]]
then
	${spades_path}/spades.py \
		-o ${out_path} \
		--meta \
		-1 ${fwd_list} \
		-2 ${bwd_list} \
		-t ${threads} -m ${spm}
else
	echo "Assembly method $meth not valid"
fi

duration=$(( SECONDS - start ))

echo "assembly: DONE"
echo " "

echo "time(sec):"
echo $duration


