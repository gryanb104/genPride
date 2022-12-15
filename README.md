**THIS WORKFLOW IS CURRENTLY INCOMPLETE AND BEING ACTIVELY EDITED. IN ITS CURRENT STATE, IT IS UNLIKELY TO WORK ON YOUR LOCAL DEVICE.**

## Description

genPride is a snakemake-based workflow for analysis of metagenomic sequence read data. It can be used for any of these purposes:

1. Determining the taxonomic makeup of a community represented by a metagenomic fasta/fastq file
2. Comparing and contrasting the taxonomic makeup of two communities
3. Reporting quality scores and time requirements of each analysis step (assembly of short reads, protein-coding prediction, and clustering/taxonomic classification of nucleotide or protein sequences).

## Usage

### 1. Install workflow

### 2. Install required scripts 

### 3. Configure workflow

Set desired parameters using config/config.yaml. This includes the path to your fastq data files and paths to installed scripts. 

Edit config/rm1_files.txt and config/rm2_files.txt to specify any post-assembly and post-clustering files unrequired for downstream analysis that you would like to keep. By default, all unneeded intermediate files are deleted to save memory.

Edit the header of GP_run.sh to define computing resources and memory to use for running this program.

### 4. Excute workflow

Make sure snakemake is installed and you have entered genPride's snakemake environment.

Run the following.

> sbatch GP_run.sh

### 5. Investigate results

Assembled sequences, amino acid sequences from identified ORFs, and clustered sequences will be automatically saved in the results directory. The final report will be automatically save in the workflow/report directory.

## The workflow

## Controling preferences with config.yaml

Use config.yaml to specify parameters of each analysis step, define directories where relevant scripts and files exist, and set computing resource limits.

* run_name: 
  *A string. This will appear at the top of the final report produced. Name your run something descriptive and memorable.*
* assemble_thresh:
  *A value between 0 and 1. **PLACEHOLDER**.*
* cluster_nuc_id:
  *A value between 0 and 1. The minimum nucleotide identity for taxonomic clustering.*
* cluster_overlap:
  *A value between 0 and 1. The minimum sequence id for taxonomic clustering.*
* trimmed_fastq_fwd_loc_list:
  *A string. The directory and filename of the trimmed fastq file containing forward reads to be analysed.*
* trimmed_fastq_bwd_loc_list:
  *A string. The directory and filename of the trimmed fastq file containing reverse reads to be analysed.*
* spades_path:
  *This workflow requires the spades program. Spades_path defines the directory in which spades.py exists. Spades can be accessed on github [here](https://github.com/ablab/spades)*
* prod_path:
  *This workflow requires the prodigal program. Prod_path defines the directory in which prodigal exists. Prodigal can be accessed on github [here](https://github.com/hyattpd/Prodigal)*
* quast_path:
  *This workflow requires the quast program. Quast_path defines the directory in which quast.py exists. Quast can be accessed on github [here](https://github.com/ablab/quast)*
* assembly_meth:
  *A string. Defines the method option of spades. These are the methods accepted by genPride: "metaspades"*
* prodigal_meth:
  *A string. Defines the method option of prodigal. These are the methods accepted by genPride: "meta"*
* mmseq_cluster_method:
  *A string. Defines the method option of mmseqs2 for clustering. These are the methods accepted by genPride: "easy_cluster"*
* mmseqs2_database:
  *A string. **PLACEHOLDER**.*
* quast_method:
  *A string. Defines the method option of quast for assembly quality analysis. These are the methods accepted by genPride: "metaQUAST"*
* threads:
  *An integer. Number of cores to use for running spades.*
* spades_py_memory:
  *An integer. Memory in GB to use for running spades.*
* rm1_files:
  *A string. Defines the directory and file name of the file defining which intermediate post-assembly files to keep and which to delete after assembly has been completed.*
* rm2_files:
  *A string. Defines the directory and file name of the file defining which intermediate post-clustering files to keep and which to delete after clustering has been completed.*
