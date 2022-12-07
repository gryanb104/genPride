#!/bin/bash

############# SET VARIABLE NAMES ################

fwd_list=$1
bwd_list=$2
method=$3
name=$4
slurm_ass=$5
ass_contigs=$6
prod_meth=$7
slurm_orf=$8
slurm_clust=$9
clust_meth=${11}
slurm_quast=${10}

############### HEADER ##########################

echo " " 
echo "                         REPORT FOR RUN"
echo "                           $name"
echo "_________________________________________________________________"
echo " "

####################### INPUT FILES #########################

filesize_fwd=$(wc -c $fwd_list | awk '{print $1}')
filesize_fwd=$(($filesize_fwd/1048576))
filesize_bwd=$(wc -c $bwd_list | awk '{print $1}')
filesize_bwd=$(($filesize_bwd/1048576))

echo "                            INPUTS"; echo " "
echo "FORWARD READS FILE : ${fwd_list##*/}"
echo -n "  SIZE OF FWD FILE : "; echo -n $filesize_fwd 
echo " MB"; echo " " 
echo "REVERSE READS FILE : ${bwd_list##*/}"
echo -n "  SIZE OF BWD FILE : "; echo -n $filesize_bwd
echo " MB"; echo " "
seqs_start_fwd=$(zcat $fwd_list | echo $((`wc -l`/4)))
contigs_end=$(grep ">" $ass_contigs | wc -l)
echo "NUMBER INPUT READS : $seqs_start_fwd"
filesize_ass=$(wc -c $ass_contigs | awk '{print $1}')
filesize_ass=$(($filesize_ass/1048576)); echo " "

################ ASSEMBLY #######################

echo "_______________________________________________________________"; echo " "
echo "                           ASSEMBLY"; echo " "
echo "ASSEMBLY METHOD GP : $method"
filesize_ass=$(wc -c $ass_contigs | awk '{print $1}')
filesize_ass=$(($filesize_ass/1048576))
echo -n "SIZE OF CONTG FILE : "; echo -n $filesize_ass; echo " MB"; echo " "

sec=$(tail -n 1 $slurm_ass); sec_ASS=$sec; min=$(($sec / 60))
only_sec=$(($sec - ($min * 60))); hour=$(($sec / 3600)); only_min=$(($min - ($hour * 60)))
num_contigs=$(grep "# contigs     " results/quast_out/combined_reference/report.txt | awk '{print $3}')
sec_f=$(printf "%f\n" $((10**6 * $sec/$seqs_start_fwd))e-6)
sec_c=$(printf "%f\n" $((10**6 * $sec/$num_contigs))e-6)

echo "ASSEMBLY TIME"
echo -n "  TOTAL TIME ELAPS : $hour"; echo -n "h $only_min"; echo -n "m $only_sec"; echo "s"
echo -n "  T PER INPUT READ : $sec_f"; echo "s"
echo -n "  T PER OUT CONTIG : $sec_c"; echo "s"; echo " "

###################### QUAST ###########################

sec=$(tail -n 1 $slurm_quast); sec_QUAST=$sec
min=$(($sec / 60)); only_sec=$(($sec - ($min * 60)))
tot_len=$(grep "Total length  " results/quast_out/combined_reference/report.txt | awk '{print $3}')
ave_len=$(($tot_len / $num_contigs))
n_fif=$(grep "N50 " results/quast_out/combined_reference/report.txt | awk '{print $2}')

echo "ASSEMBLY QUALITY REPORT (QUAST)"
echo -n "  TOTAL QUAST TIME : " ; echo -n "$min"; echo -n "m $only_sec"; echo "s"
echo -n "  NUMBR OF CONTIGS : " ; echo $num_contigs
echo -n "  TOT ASSEMBLY LEN : " ; echo $tot_len
echo -n "  AVG CONTIG LNGTH : " ; echo $ave_len
echo -n "  N50 (CNT METRIC) : " ; echo $n_fif; echo " "

####################### PROTEIN SEQUENCING ###################

sec=$(tail -n 1 $slurm_orf); sec_ORF=$sec; min=$(($sec / 60))
only_sec=$(($sec - ($min * 60))); hour=$(($sec / 3600))
only_min=$(($min - ($hour * 60)))

echo "_________________________________________________________________"
echo " "; echo "                       PROTEIN SEQUENCING"
echo " "; echo "PROTEIN SEQ METHOD : $prod_meth"
echo "PROTEINS SEQUENCED : $contigs_end"; 
echo " "; echo "PROTEIN SEQUENCE TIME"
echo -n "  TOTAL TIME ELAPS : $hour"; echo -n "h $only_min"; echo -n "m $only_sec"; echo "s"
sec_c=$(printf "%f\n" $((10**6 * $sec/$contigs_end))e-6)
echo -n "  TIME PER PROTEIN : $sec_c"; echo "s"; echo " "

######################## CLUSTERING ########################

sec=$(tail -n 1 $slurm_clust); sec_CLUST=$sec; min=$(($sec / 60))
only_sec=$(($sec - ($min * 60))); hour=$(($sec / 3600))
only_min=$(($min - ($hour * 60)))

echo "_________________________________________________________________"
echo " "; echo "                       PROTEIN CLUSTERING"; echo " "
echo "PROTEIN CLUST METH : $clust_meth"; echo " "; echo "CLUSTER TIME"
echo -n "  TOTAL TIME ELAPS : $hour"; echo -n "h $only_min"; echo -n "m $only_sec"; echo "s"
sec_c=$(printf "%f\n" $((10**6 * $sec/$contigs_end))e-6)
echo -n "  TIME PER PROTEIN : $sec_c"; echo "s"; echo " "
echo "_________________________________________________________________"

######################## TOTALS ###############################

tot_sec=$(($sec_ASS + $sec_ORF + $sec_CLUST)); sec=$tot_sec
min=$(($sec / 60)); only_sec=$(($sec - ($min * 60)))
hour=$(($sec / 3600)); only_min=$(($min - ($hour * 60)))

echo " "; echo "                            TOTAL"; echo " "
echo "TOTAL TIME"
echo -n "  TOTAL TIME ELAPS : $hour"; echo -n "h $only_min"; echo -n "m $only_sec"; echo "s"
sec_c=$(printf "%f\n" $((10**6 * $sec/$contigs_end))e-6)
