#!/bin/bash
#SBATCH -J metaSpades                  # Job name
#SBATCH -n 20                                    # Number of cpus
#SBATCH -N 1     # Number of physical nodes
#SBATCH --mem=250000
#SBATCH -t 2-00:00:00                           # Runtime in D-HH:MM:SS
#SBATCH -p sched_mit_chisholm        # Partition to submit to
#SBATCH --exclusive  #needs exclusive use of this node...

echo [`date +"%D %T"`] STARTED 1>&2;

sourcedir="/nobackup1/sbiller/vesicle_metagenomes/assemblies/merged_reads"
destdir="/nobackup1/sbiller/vesicle_metagenomes/assemblies/merged_spades"

softwaredir="/nobackup1/chisholmlab/software/SPAdes-3.12.0-Linux"

$softwaredir/bin/spades.py \
     -t 20 -m 250 \
     --meta \
     -o ${destdir}/assembly_312 \
     -1 ${sourcedir}/fwdlib_nooverlapping_qctrimmed_pairs_1.fastq.gz \
     -2 ${sourcedir}/revlib_nooverlapping_qctrimmed_pairs_2.fastq.gz 
    
echo [`date +"%D %T"`] DONE 1>&2;
