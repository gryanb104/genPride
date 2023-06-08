#!/bin/bash

#reassign variable names

nextflow_path=$1
contigs=$2
gorg_path=$3
sample=$4
outdir=results/06-gorg_classification/${sample}_classification

start=$SECONDS

${nextflow_path}/nextflow run BigelowLab/gorg-classifier --seqs $contigs --outdir $outdir

#make text file of reports
sed -e 's/<[^>]*>//g' ${outdir}/logs/GORG-Classifier_report.html > ${outdir}/logs/GORG-Classifier_report.txt
sed -e 's/<[^>]*>//g' ${outdir}/logs/GORG-Classifier_timeline.html > ${outdir}/logs/GORG-Classifier_timeline.txt

echo "time(sec):"
echo $(( SECONDS - start))

gorg_status=$(grep "Workflow execution completed" ${outdir}/logs/GORG-Classifier_report.txt)
echo " "
echo "status:"
echo -n $gorg_status | sed 's/Workflow execution completed //g' | sed 's/ly!//g'

gunzip -f $outdir/annotations/*
