#!/bin/bash

#set variable names

fwd_list=$1
bwd_list=$2
method=$3
name=$4
slurm_ass=$5
ass_contigs=$6

#report inputs

#header

echo " "
echo "                     ASSEMBLE REPORT FOR RUN"
echo "                          $name"
echo "_________________________________________________________________"
echo " "


#method
echo "ASSEMBLY METHOD GP : $method"

#inputs
echo "FORWARD READS FILE : ${fwd_list##*/}"
echo "REVERSE READS FILE : ${bwd_list##*/}"
echo " "
echo "_________________________________________________________________"
echo " "

#report meat

seqs_start_fwd=$(zcat $fwd_list | echo $((`wc -l`/4)))
contigs_end=$(grep ">" $ass_contigs | wc -l)

echo "NUMBER OF SEQUENCES"
echo "  NUMB INPUT READS : $seqs_start_fwd"
echo "  N OUTPUT CONTIGS : $contigs_end" 
echo " "

sec=$(tail -n 1 $slurm_ass)
min=$(($sec / 60))
only_sec=$(($sec - ($min * 60)))
hour=$(($sec / 3600))
only_min=$(($min - ($hour * 60)))

echo "ASSEMBLY TIME"
echo -n "  TOTAL TIME ELAPS : $hour"
echo -n "h $only_min"
echo -n "m $only_sec"
echo "s"

sec_f=$(printf "%f\n" $((10**6 * $sec/$seqs_start_fwd))e-6)
sec_c=$(printf "%f\n" $((10**6 * $sec/$contigs_end))e-6)

echo -n "  T PER INPUT READ : $sec_f"
echo "s"
echo -n "  T PER OUT CONTIG : $sec_c"
echo "s"
