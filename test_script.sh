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
meth="metaspades"
name="test_name"
slurm_ass="results/slurm_ass.out"
prod_path="/nobackup1/chisholmlab/software/Prodigal/"
prod_meth="meta"

prot_seqs="/nobackup1/billerlab/gray/genPride/results/protein_seqs/protein_translations.faa"
mmseq_meth="easy_cluster"
nuc_id=0.95
overlap=0.9

slurm_orf="results/slurm_orf.out"

slurm_clust="results/slurm_clust.out"
clust_meth="easy_cluster"

quast_path="/nobackup1/billerlab/gray/quast"
contigs="results/assembled_seqs/contigs.fasta"
quast_meth="metaQUAST"
slurm_quast="results/slurm_quast.out"

rm1_files="config/rm1_files.txt"
RM1_rep="results/assembled_seqs/RM1_rep.txt"

#bash workflow/scripts/assemble_meat.sh $fwd $bwd $meth 0.95 $threads $spm $spades_path
#bash workflow/scripts/assemble_report.sh $fwd $bwd $meth $name $slurm_ass $ass_contigs $prod_meth \
#$slurm_orf $slurm_clust $slurm_quast $clust_meth> TEST_ASS_REPORT.txt
#bash workflow/scripts/find_orfs.sh $ass_contigs $prod_path $prod_meth > TEST_ORF_REPORT.txt
#bash workflow/scripts/cluster_gen.sh $prot_seqs $mmseq_meth $nuc_id $overlap > TEST_CLUST_slurm.out
#bash workflow/scripts/quasting.sh $quast_path $contigs $quast_meth
bash workflow/scripts/RM1.sh $rm1_files > $RM1_rep
