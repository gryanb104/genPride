#!/bin/bash

############# SET VARIABLE NAMES ################

fwd_list=$1
bwd_list=$2
meth=$3
name=$4
slurm_ass=$5
ass_contigs=$6
prod_meth=$7
slurm_orf=$8
slurm_clust=$9
clust_meth=${11}
slurm_quast=${10}
snake_comp=${12}

############### HEADER ##########################

source workflow/rules/print_report.smk

print_head $name $snake_comp

echo " " 
echo "                         REPORT FOR RUN"
echo "                           $name"
echo " "
echo "-----------------------------------------------------------------"

####################### INPUT FILES #########################

filesize_fwd=$(wc -c $fwd_list | awk '{print $1}')
filesize_fwd=$(($filesize_fwd/1048576))
filesize_bwd=$(wc -c $bwd_list | awk '{print $1}')
filesize_bwd=$(($filesize_bwd/1048576))
seqs_start_fwd=$(zcat $fwd_list | echo $((`wc -l`/4)))

echo " "
echo "                            INPUTS"
echo "FORWARD READS INPUT" 
echo "  FRWRD READS FILE : ${fwd_list##*/}"
echo -n "  SIZE OF FWD FILE : $filesize_fwd"; echo " MB" 
echo "REVERSE READS INPUT"
echo "  RVRSE READS FILE : ${bwd_list##*/}"
echo -n "  SIZE OF BWD FILE : $filesize_bwd"; echo " MB"
echo "NUMBER INPUT READS : $seqs_start_fwd"
echo " " 
echo "-----------------------------------------------------------------"

################ ASSEMBLY #######################

filesize_ass=$(wc -c $ass_contigs | awk '{print $1}')
filesize_ass=$(($filesize_ass/1048576))
sec=$(tail -n 1 $slurm_ass); sec_ASS=$sec; min=$(($sec / 60))
only_sec=$(($sec - ($min * 60))); hour=$(($sec / 3600))
only_min=$(($min - ($hour * 60)))
num_contigs=$(grep "# contigs     " results/quast_out/combined_\
reference/report.txt | awk '{print $3}')
sec_f=$(printf "%f\n" $((10**6 * $sec/$seqs_start_fwd))e-6)
sec_c=$(printf "%f\n" $((10**6 * $sec/$num_contigs))e-6)

echo " "
echo "                           ASSEMBLY"
echo "ASSEMBLY METHOD GP : $meth"
filesize_ass=$(wc -c $ass_contigs | awk '{print $1}')
filesize_ass=$(($filesize_ass/1048576))
echo -n "SIZE OF CONTG FILE : "; echo -n $filesize_ass; echo " MB"
echo "ASSEMBLY TIME"
echo -n "  TOTAL TIME ELAPS : $hour"; echo -n "h $only_min"
echo -n "m $only_sec"; echo "s"
echo -n "  T PER INPUT READ : $sec_f"; echo "s"
echo -n "  T PER OUT CONTIG : $sec_c"; echo "s"

###################### QUAST ###########################

sec=$(tail -n 1 $slurm_quast); sec_QUAST=$sec
min=$(($sec / 60)); only_sec=$(($sec - ($min * 60)))
tot_len=$(grep "Total length  " results/quast_out/combined_\
reference/report.txt | awk '{print $3}')
ave_len=$(($tot_len / $num_contigs))
n_fif=$(grep "N50 " results/quast_out/combined_\
reference/report.txt | awk '{print $2}')

echo 'ASSEMBLY QUALITY REPORT (QUAST)'
echo -n "  TOTAL QUAST TIME : $min"; echo -n "m $only_sec"; echo "s"
echo "  NUMBR OF CONTIGS : $num_contigs"
echo "  TOT ASSEMBLY LEN : $tot_len"
echo "  AVG CONTIG LNGTH : $ave_len"
echo "  N50 (CNT METRIC) : $n_fif" 
echo " "
echo "-----------------------------------------------------------------"

####################### PROTEIN SEQUENCING ###################

sec=$(tail -n 1 $slurm_orf); sec_ORF=$sec; min=$(($sec / 60))
only_sec=$(($sec - ($min * 60))); hour=$(($sec / 3600))
only_min=$(($min - ($hour * 60)))

echo " "
echo "                       PROTEIN SEQUENCING"
echo "PROTEIN SEQ METHOD : $prod_meth" 
echo "PROTEIN SEQUENCE TIME"
echo -n "  TOTAL TIME ELAPS : $hour"; echo -n "h $only_min"
echo -n "m $only_sec"; echo "s"
sec_c=$(printf "%f\n" $((10**6 * $sec/$num_contigs))e-6)
echo -n "  TIME PER PROTEIN : $sec_c"; echo "s"
echo " "
echo "-----------------------------------------------------------------"

######################## CLUSTERING ########################

sec=$(tail -n 1 $slurm_clust); sec_CLUST=$sec; min=$(($sec / 60))
only_sec=$(($sec - ($min * 60))); hour=$(($sec / 3600))
only_min=$(($min - ($hour * 60)))
clust_num=$(awk -F ',' '{print $1}' ./results/clustered_seqs/clust_cluster.tsv | sort | uniq | wc -l)

echo " "
echo "                       PROTEIN CLUSTERING"
echo "PROTEIN CLUST METH : $clust_meth"
echo "TOTAL NUM CLUSTERS : $clust_num" 
echo "CLUSTER TIME"
echo -n "  TOTAL TIME ELAPS : $hour"; echo -n "h $only_min"
echo -n "m $only_sec"; echo "s"
sec_c=$(printf "%f\n" $((10**6 * $sec/$num_contigs))e-6)
echo -n "  TIME PER PROTEIN : $sec_c"; echo "s"
echo " "
echo "-----------------------------------------------------------------"

######################## TOTALS ###############################

tot_sec=$(($sec_ASS + $sec_ORF + $sec_CLUST + $sec_QUAST)); sec=$tot_sec
min=$(($sec / 60)); only_sec=$(($sec - ($min * 60)))
hour=$(($sec / 3600)); only_min=$(($min - ($hour * 60)))

echo " "
echo "                            TOTAL"
echo "TOTAL TIME"
echo -n "  TOTAL TIME ELAPS : $hour"; echo -n "h $only_min"
echo -n "m $only_sec"; echo "s"
sec_c=$(printf "%f\n" $((10**6 * $sec/$num_contigs))e-6)
