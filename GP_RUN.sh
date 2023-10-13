#!/bin/bash
#SBATCH --job-name=sbst_cvrg_test	#job name
#SBATCH --nodes=1			#number of nodes to use
#SBATCH --ntasks=20			#number of cpus to use
#SBATCH --mem=2500 #00			#maximum memory
#SBATCH --time=0-08:00:00		#maximum time to run
#SBATCH --partition=sched_mit_chisholm	#partition name
#SBATCH --exclusive			#exclusive use of node

source ~/.bashrc
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
cores=16

conda activate snakeGenPride
snakemake --unlock
snakemake --cores $cores
