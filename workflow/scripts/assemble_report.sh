#!/bin/bash

#SET VAR NAMES AND SOURCE
samp_doc=$1; name=$2; slurm_ass=$3; ass_contigs=$4
slurm_orf=$5; slurm_clust=$6; slurm_quast=${7}; slurm_gorg=${8}
slurm_krona=${9}; sample=${10}

fwd_list="$(grep 'FWD READ FILE:' $samp_doc | sed 's/^.*: //')"
bwd_list="$(grep 'REV READ FILE:' $samp_doc | sed 's/^.*: //')"
ass_meth="$(grep '    ASSEMBLY  :' $samp_doc | sed 's/^.*: //')"
prod_meth="$(grep '    GENE PRED :' $samp_doc | sed 's/^.*: //')"
clust_meth="$(grep '    CLUSTERING:' $samp_doc | sed 's/^.*: //')"

source workflow/rules/report.smk

#PRINT HEADER
print_head $name $sample

#PRINT INPUT FILES
print_inp $fwd_list $bwd_list

#PRINT ASSEMBLY SUMMARY
rep_path=$(get_report_path $sample)
print_assembly $ass_contigs $slurm_ass $fwd_list $ass_meth $sample $rep_path

####################### GORG ###########################

gorg_status=$(tail -n 1 $slurm_gorg)
gorg_time=$(tail -n 4 $slurm_gorg | head -n 1)
kaiju_mismatches=$(grep "Kaiju mismatches" $slurm_gorg | sed 's/[^,:]*: //g')
kaiju_min_al=$(grep "Kaiju minimum alignment length" $slurm_gorg | sed 's/[^,:]*: //g')
kaiju_cpus=$(grep "Kaiju CPUs" $slurm_gorg | sed 's/[^,:]*: //g')

gorg_sum="results/06-gorg_classification/${sample}_classification/summaries/contigs_summary.txt"
gorg_seqs=$(grep "Sequences" $gorg_sum | sed 's/[^,:]*: //g')
g_super=$(grep "Superkingdom" $gorg_sum | sed 's/[^,:]*: //g')
g_super_num=$(echo $g_super | awk '{print $1}')
g_super_per=$(echo $g_super | awk '{print $2}')
g_phylum=$(grep "Phylum" $gorg_sum | sed 's/[^,:]*: //g')
g_phylum_num=$(echo $g_phylum | awk '{print $1}')
g_phylum_per=$(echo $g_phylum | awk '{print $2}')
g_class=$(grep "Class" $gorg_sum | sed 's/[^,:]*: //g')
g_class_num=$(echo $g_class | awk '{print $1}')
g_class_per=$(echo $g_class | awk '{print $2}')
g_order=$(grep "Order" $gorg_sum | sed 's/[^,:]*: //g')
g_order_num=$(echo $g_order | awk '{print $1}')
g_order_per=$(echo $g_order | awk '{print $2}')
g_family=$(grep "Family" $gorg_sum | sed 's/[^,:]*: //g')
g_family_num=$(echo $g_family | awk '{print $1}')
g_family_per=$(echo $g_family | awk '{print $2}')
g_genus=$(grep "Genus" $gorg_sum | sed 's/[^,:]*: //g')
g_genus_num=$(echo $g_genus | awk '{print $1}')
g_genus_per=$(echo $g_genus | awk '{print $2}')
g_species=$(grep "Species" $gorg_sum | sed 's/[^,:]*: //g')
g_species_num=$(echo $g_species | awk '{print $1}')
g_species_per=$(echo $g_species | awk '{print $2}')
g_functional=$(grep "Function:" $gorg_sum | sed 's/[^,:]*: //g')
g_functional_num=$(echo $g_functional | awk '{print $1}')
g_functional_per=$(echo $g_functional | awk '{print $2}')
g_nonhyp=$(grep "Non-hypothetical" $gorg_sum | sed 's/[^,:]*: //g')
g_nonhyp_num=$(echo $g_nonhyp | awk '{print $1}')
g_nonhyp_per=$(echo $g_nonhyp | awk '{print $2}')
g_ec=$(grep "EC" $gorg_sum | sed 's/[^,:]*: //g')
g_ec_num=$(echo $g_ec | awk '{print $1}')
g_ec_per=$(echo $g_ec | awk '{print $2}')

echo " "
echo "                  GORG CLASSIFICATION REPORT"
echo "COMPLETION  STATUS : $gorg_status"
echo "TOTAL ELAPSED TIME : $(secs_to_time $gorg_time)"
echo "GORGC TIME IN SECS : $sec"
echo "KAIJU PARAMETERS"
echo "  KAIJU MISMATCHES : $kaiju_mismatches"
echo "  MIN ALIGNMNT LEN : $kaiju_min_al"
echo "  KAIJU  COMPUTERS : $kaiju_cpus"
echo "NUMBR OF SEQUENCES : $gorg_seqs"
echo " "
echo "TAXONOMY ASSIGNMENTS "
echo "   _____________________________________________"
echo "  |_TAXONOMIC LEVEL_|_____COUNT_____|__PERCENT__|"
echo -n "  | SUPERKINGDOM    | "; printf '%-13s' "$g_super_num"; echo -n " | "
printf '%-11s' "$g_super_per" | sed 's/[)(]//g'; echo " | " 
echo -n "  | PHYLUM          | "; printf '%-13s' "$g_phylum_num"; echo -n " | "
printf '%-11s' "$g_phylum_per" | sed 's/[)(]//g'; echo " | "
echo -n "  | CLASS           | "; printf '%-13s' "$g_class_num"; echo -n " | "
printf '%-11s' "$g_class_per" | sed 's/[)(]//g'; echo " | "
echo -n "  | ORDER           | "; printf '%-13s' "$g_order_num"; echo -n " | "
printf '%-11s' "$g_order_per" | sed 's/[)(]//g'; echo " | "
echo -n "  | FAMILY          | "; printf '%-13s' "$g_family_num"; echo -n " | "
printf '%-11s' "$g_family_per" | sed 's/[)(]//g'; echo " | "
echo -n "  | GENUS           | "; printf '%-13s' "$g_genus_num"; echo -n " | "
printf '%-11s' "$g_genus_per" | sed 's/[)(]//g'; echo " | "
echo -n "  | SPECIES         | "; printf '%-13s' "$g_species_num"; echo -n " | "
printf '%-11s' "$g_species_per" | sed 's/[)(]//g'; echo " | "
echo " "
echo "FUNCTIONAL ASSIGNMENTS "
echo "   ______________________________________________"
echo "  |____ASSIGNMENT____|_____COUNT_____|__PERCENT__|"
echo -n "  | FUNCTION         | "; printf '%-13s' "$g_functional_num"; echo -n " | "
printf '%-11s' "$g_functional_per" | sed 's/[)(]//g'; echo " | "
echo -n "  | NON-HYPOTHETICAL | "; printf '%-13s' "$g_nonhyp_num"; echo -n " | "
printf '%-11s' "$g_nonhyp_per" | sed 's/[)(]//g'; echo " | "
echo -n "  | EC               | "; printf '%-13s' "$g_ec_num"; echo -n " | "
printf '%-11s' "$g_ec_per" | sed 's/[)(]//g'; echo " | "
echo " "
echo "-----------------------------------------------------------------"


###################### KRONA ###########################

sec=$(tail -n 1 $slurm_krona)
time=$(secs_to_time $sec)

echo " "
echo "                     KRONA REPORT"
echo "TOTAL TIME ELAPSED : $time"
echo "TOTAL TIME IN SECS : $sec"
echo " "
echo "-----------------------------------------------------------------"

###################### QUAST ###########################

sec=$(tail -n 1 $slurm_quast); sec_QUAST=$sec
min=$(($sec / 60)); only_sec=$(($sec - ($min * 60)))
tot_len=$(grep "Total length  " $rep_path | awk '{print $3}')
ave_len=$(($tot_len / $num_contigs))
n_fif=$(grep "N50 " $rep_path | awk '{print $2}')

echo " "
echo '              ASSEMBLY QUALITY REPORT (QUAST)'
echo -n "  TOTAL QUAST TIME : $min"; echo -n "m $only_sec"; echo "s"
echo "  TOT TIME IN SECS : $sec"
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
echo "  TOT TIME IN SECS : $sec"
echo -n "  TIME PER PROTEIN : $sec_c"; echo "s"
echo " "
echo "-----------------------------------------------------------------"

######################## CLUSTERING ########################

sec=$(tail -n 1 $slurm_clust); sec_CLUST=$sec; min=$(($sec / 60))
only_sec=$(($sec - ($min * 60))); hour=$(($sec / 3600))
only_min=$(($min - ($hour * 60)))
clust_num=$(awk -F ',' '{print $1}' ./results/05-clustered_seqs/${sample}_cluster/${sample}_cluster.tsv | sort | uniq | wc -l)

echo " "
echo "                       PROTEIN CLUSTERING"
echo "PROTEIN CLUST METH : $clust_meth"
echo "TOTAL NUM CLUSTERS : $clust_num" 
echo "CLUSTER TIME"
echo -n "  TOTAL TIME ELAPS : $hour"; echo -n "h $only_min"
echo -n "m $only_sec"; echo "s"
echo "  TOT TIME IN SECS : $sec"
sec_c=$(printf "%f\n" $((10**6 * $sec/$num_contigs))e-6)
echo -n "  TIME PER PROTEIN : $sec_c"; echo "s"
echo " "
echo "-----------------------------------------------------------------"

######################## TOTALS ###############################

sec_ASS=$(tail -n 1 $slurm_ass)
sec_ORF=$(tail -n 1 $slurm_orf)
sec_CLUST=$(tail -n 1 $slurm_clust)
sec_QUAST=$(tail -n 1 $slurm_quast)
sec_GORG=$(tail -n 1 $end_gorg) | head -n 1
sec_KRONA=$(tail -n 1 $slurm_krona)
tot_sec=$(($sec_ASS + $sec_ORF + $sec_CLUST + $sec_QUAST + $sec_GORG + $sec_KRONA))
time=$(secs_to_time $tot_sec)

echo " "
echo "                            TOTAL"
echo "TOTAL TIME"
echo -n "  TOTAL TIME ELAPS : $time"
sec_c=$(printf "%f\n" $((10**6 * $sec/$num_contigs))e-6)
