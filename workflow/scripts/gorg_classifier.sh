#1/bin/bash

#reassign variable names

gorg_path=$1
contigs=$2
outdir=$3

${gorg_path}/nextflow run BigelowLab/gorg-classifier -profile docker --seqs \ 
	$contigs --outdir $outdir


