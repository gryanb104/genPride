#!/bin/bash
#SBATCH --job-name=sbst_cvrg_test	#job name
#SBATCH --nodes=1			#number of nodes to use
#SBATCH --ntasks=20			#number of cpus to use
#SBATCH --mem=250000			#maximum memory
#SBATCH --time=0-08:00:00		#maximum time to run
#SBATCH --partition=sched_mit_chisholm	#partition name
#SBATCH --exclusive			#exclusive use of node

source ~/.bashrc
conda activate snakeGenPride
snakemake --unlock

doc_inp=$(python3 workflow/scripts/getDocInp.py)

#snakemake --cores 16 --config final_output=$doc_inp $doc_inp
snakemake --cores 16
