#!/bin/bash

#set variable names

fwd_list=$1
bwd_list=$2
method=$3
name=$4
slurm_ass=$5
ass_contigs=$6
prod_meth=$7
slurm_orf=$8
slurm_clust=$9
clust_meth=${10}

#report inputs

#header

echo " "
echo "                         REPORT FOR RUN"
echo "                           $name"
echo "_________________________________________________________________"
echo " "
echo "                           ASSEMBLY"
echo " "
echo "ASSEMBLY METHOD GP : $method"
echo "FORWARD READS FILE : ${fwd_list##*/}"
echo "REVERSE READS FILE : ${bwd_list##*/}"
echo " "

seqs_start_fwd=$(zcat $fwd_list | echo $((`wc -l`/4)))
contigs_end=$(grep ">" $ass_contigs | wc -l)

echo "NUMBER OF SEQUENCES"
echo "  NUMB INPUT READS : $seqs_start_fwd"
echo "  N OUTPUT CONTIGS : $contigs_end" 
echo " "

sec=$(tail -n 1 $slurm_ass)
sec_ASS=$sec
min=$(($sec / 60))
only_sec=$(($sec - ($min * 60)))
hour=$(($sec / 3600))
only_min=$(($min - ($hour * 60)))

echo "ASSEMBLY TIME"
echo -n "  TOTAL TIME ELAPS : $hour"; echo -n "h $only_min"; echo -n "m $only_sec"; echo "s"

sec_f=$(printf "%f\n" $((10**6 * $sec/$seqs_start_fwd))e-6)
sec_c=$(printf "%f\n" $((10**6 * $sec/$contigs_end))e-6)

echo -n "  T PER INPUT READ : $sec_f"; echo "s"
echo -n "  T PER OUT CONTIG : $sec_c"; echo "s"

echo " "
echo "_________________________________________________________________"
echo " "
echo "                       PROTEIN SEQUENCING"
echo " "
echo "PROTEIN SEQ METHOD : $prod_meth"
echo " "
echo "PROTEINS SEQUENCED : $contigs_end"
echo " "

sec=$(tail -n 1 $slurm_orf)
sec_ORF=$sec
min=$(($sec / 60))
only_sec=$(($sec - ($min * 60)))
hour=$(($sec / 3600))
only_min=$(($min - ($hour * 60)))

echo "PROTEIN SEQUENCE TIME"
echo -n "  TOTAL TIME ELAPS : $hour"; echo -n "h $only_min"; echo -n "m $only_sec"; echo "s"
sec_c=$(printf "%f\n" $((10**6 * $sec/$contigs_end))e-6)
echo -n "  TIME PER PROTEIN : $sec_c"; echo "s"

echo " "
echo "_________________________________________________________________"
echo " "
echo "                       PROTEIN CLUSTERING"
echo " "

echo "PROTEIN CLUST METH : $clust_meth"
echo " "

sec=$(tail -n 1 $slurm_clust)
sec_CLUST=$sec
min=$(($sec / 60))
only_sec=$(($sec - ($min * 60)))
hour=$(($sec / 3600))
only_min=$(($min - ($hour * 60)))

echo "CLUSTER TIME"
echo -n "  TOTAL TIME ELAPS : $hour"; echo -n "h $only_min"; echo -n "m $only_sec"; echo "s"
sec_c=$(printf "%f\n" $((10**6 * $sec/$contigs_end))e-6)
echo -n "  TIME PER PROTEIN : $sec_c"; echo "s"

