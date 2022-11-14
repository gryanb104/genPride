#!/bin/bash
#SBATCH --job-name=GP_test             #job name
#SBATCH --nodes=1                       #number of nodes to use
#SBATCH --ntasks=20                     #number of cpus to use
#SBATCH --mem=250000                    #maximum memory
#SBATCH --time=2-00:00:00               #maximum time to run
#SBATCH --partition=sched_mit_chisholm  #partition name
#SBATCH --exclusive                     #exclusive use of node

fwd="/nobackup1/billerlab/gray/data_GP/subset_fwd.fastq.gz"
bwd="/nobackup1/billerlab/gray/data_GP/subset_bwd.fastq.gz"
meth="metaspades"
threads=20
spm=250
spades_path="/home/billerlab/software/SPAdes-3.15.5-Linux/bin/"

bash workflow/scripts/assemble_meat.sh $fwd $bwd $meth 0.95 $threads $spm $spades_path

