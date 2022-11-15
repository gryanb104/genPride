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
ass_contigs="/nobackup1/billerlab/gray/genPride/results/assembled_seqs/contigs.fasta"
#meth="metaspades"
#threads=20
#spm=250
#spades_path="/home/billerlab/software/SPAdes-3.15.5-Linux/bin/"

#bash workflow/scripts/assemble_meat.sh $fwd $bwd $meth 0.95 $threads $spm $spades_path

bash workflow/scripts/assemble_report.sh $fwd $bwd "metaspades" "test_name" results/slurm_ass.out $ass_contigs > TEST_ASS_REPORT.txt

