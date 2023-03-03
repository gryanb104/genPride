#1/bin/bash

#reassign variable names

gorg_path=$1
contigs=$2
outdir=results/gorg_classification

start=$SECONDS

#${gorg_path}/nextflow run BigelowLab/gorg-classifier -profile docker --seqs $contigs --outdir $outdir

echo "test" > results/gorg_classification/gorg.out
echo "time(sec):"
echo $(( SECONDS - start))

