#1/bin/bash

#reassign variable names

gorg_path=$1
contigs=$2
outdir=results/gorg_classification

#${gorg_path}/nextflow run BigelowLab/gorg-classifier -profile docker --seqs $contigs --outdir $outdir

echo $gorg_path
echo $contigs
echo $outdir

echo "test" > results/gorg_classification/gorg.out

