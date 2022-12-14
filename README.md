# genPride

genPride is a snakemake-based workflow for analysis of metagenomic sequence read data. It can be used for any of these purposes:

1. Determining the taxonomic makeup of a community represented by a metagenomic fasta/fastq file

2. Comparing and contrasting the taxonomic makeup of two communities

3. Reporting quality scores and time requirements of each analysis step (assembly of short reads, protein-coding prediction, and clustering/taxonomic classification of nucleotide or protein sequences).
  
## The workflow

## Controling preferences with config.yaml

Use config.yaml to specify parameters of each analysis step, define directories where relevant scripts and files exist, and set computing resource limits.

* run_name: 
  A string. This will appear at the top of the final report produced. Name your run something descriptive and memorable.
* assemble_thresh: 
  A value between 0 and 1. This is the minimum match required to assemble reads into contigs.
* cluster_nuc_id:
  A value between 0 and 1. The minimum nucleotide identity required for taxonomic clustering.
* cluster_overlap:
  A value between 0 and 1. The minimum required overlap for the clustering step.
* trimmed_fastq_fwd_loc_list:
  A string. The directory and filename of the trimmed fastq file containing forward reads to be analysed.
* trimmed_fastq_bwd_loc_list:
  A string. The directory and filename of the trimmed fastq file containing reverse reads to be analysed.
* spades_path:
  This workflow requires the spades program. Spades_path defines the directory in which spades.py exists.
* prod_path:
  This workflow requires the prodigal program. Prod_path defines the directory in which prodigal.py exists.
* quast_path:
  This workflow requires the quast program. Quast_path defines the directory in which quast.sh exists.
