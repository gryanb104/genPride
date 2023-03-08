#!/bin/bash
#SBATCH --job-name=genPride		#job name
#SBATCH --nodes=1			#number of nodes to use
#SBATCH --ntasks=20			#number of cpus to use
#SBATCH --mem=250000			#maximum memory
#SBATCH --time=2-00:00:00		#maximum time to run
#SBATCH --partition=sched_mit_chisholm	#partition name
#SBATCH --exclusive			#exclusive use of node

cd /nobackup1/biller/gray/genPride

snakemake --unlock
snakemake --cores 1
