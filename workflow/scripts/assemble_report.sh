#!/bin/bash

#SET VAR NAMES AND SOURCE
fwd_list=$1; bwd_list=$2; meth=$3; name=$4
slurm_ass=$5; ass_contigs=$6; prod_meth=$7
slurm_orf=$8; slurm_clust=$9; clust_meth=${11}
slurm_quast=${10}; snake_comp=${12}
source workflow/rules/report.smk

#PRINT HEADER
print_head $name

#PRINT INPUT FILES
print_inp $fwd_list $bwd_list

#PRINT ASSEMBLY SUMMARY
print_assembly $ass_contigs $slurm_ass $fwd_list $meth


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
