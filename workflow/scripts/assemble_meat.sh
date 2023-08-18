#!/bin/bash

#reassign variable names

out_path=$1
ass_thresh=$2
threads=$3
spm=$4
spades_path=$5
contig_output=$6
sample=$7
meth=$8
fwd_list=$9
bwd_list=${10}
paired=${11}
min_contig_length=${12}

#reset timer
start=$SECONDS

meth_first="$(echo $meth | grep -o '^[^:]*')"
meth_second="$(echo $meth | awk -F ':' '{print $2}')"

if [[ "$meth_first" == "spades" ]] && [[ "$meth_second" == "metaspades" ]]
then
	if [[ "$paired" == "NO" ]] || [[ "$paired" == "No" ]] || [[ "$paired" == "no" ]]
	then
		echo "Metaspades assembly cannot be used for unpaired reads"
	else
		${spades_path}/spades.py \
			-o ${out_path} \
			--meta \
			-1 ${fwd_list} \
			-2 ${bwd_list} \
			-t ${threads} -m ${spm}
	fi
elif [[ "$meth_first" == "megahit" ]]
then
	if [[ "$paired" == "NO" ]] || [[ "$paired" == "No" ]] || [[ "$paired" == "no" ]]
	then
		rm -r $out_path
		megahit -r "$fwd_list" -t $threads --min-contig-len $min_contig_length --presets $meth_second -o $out_path
		mv ${out_path}final.contigs.fa ${out_path}contigs.fasta
	else
		rm -r $out_path
		megahit -1 "$fwd_list" -2 "$bwd_list" -t $threads --min-contig-len $min_contig_length --presets $meth_second -o $out_path
		mv ${out_path}final.contigs.fa ${out_path}contigs.fasta
	fi
else
	echo "Assembly method $meth not valid"
fi

duration=$(( SECONDS - start ))

echo "assembly: DONE"
echo " "

echo "time(sec):"
echo $duration


