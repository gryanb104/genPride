#!/bin/bash
#SBATCH --job-name=covrSumTest          #job name
#SBATCH --nodes=1                       #number of nodes to use
#SBATCH --ntasks=20                     #number of cpus to use
#SBATCH --mem=25000                     #maximum memory
#SBATCH --time=0-00:15:00               #maximum time to run
#SBATCH --partition=sched_mit_chisholm  #partition name

input_file="/nobackup1/biller/gray/COVR_OCT2023/results/08-coverage/all_ves_vir_coverage/all_ves_vir_coverage"
output_file="/nobackup1/biller/gray/COVR_OCT2023/results/08-coverage/all_ves_vir_coverage/all_ves_vir_coverage_report.txt"
sample="all_ves_vir"
multi_bam="/nobackup1/biller/gray/COVR_OCT2023/results/08-coverage/all_ves_vir_coverage/multi-bam-merge-for-all_ves_vir-coverage_sorted.bam"
coverage_out="/nobackup1/biller/gray/COVR_OCT2023/results/08-coverage/all_ves_vir_coverage/all_ves_vir_coverage_depth.coverage"

python3 workflow/scripts/sum_coverage.py $input_file $sample $multi_bam > $output_file
samtools flagstat $multi_bam >> $output_file
#bash workflow/scripts/make_depth_from_multibam.sh $multi_bam $coverage_out
