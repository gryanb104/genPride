#!/bin/bash

#reassign variable names

nextflow_path=$1
contigs=$2
gorg_path=$3
outdir=results/gorg_classification

start=$SECONDS

${nextflow_path}/nextflow run BigelowLab/gorg-classifier --seqs $contigs --outdir $outdir

#make text file of reports
sed -e 's/<[^>]*>//g' results/gorg_classification/logs/GORG-Classifier_report.html > results/gorg_classification/logs/GORG-Classifier_report.txt
sed -e 's/<[^>]*>//g' results/gorg_classification/logs/GORG-Classifier_timeline.html > results/gorg_classification/logs/GORG-Classifier_timeline.txt

echo "time(sec):"
echo $(( SECONDS - start))

gorg_status=$(grep "Workflow execution completed" /nobackup1/biller/gray/genPride/results/gorg_classification/logs/GORG-Classifier_report.txt)
echo " "
echo "status:"
echo $gorg_status | sed 's/Workflow execution completed //g' | sed 's/ly!//g'

