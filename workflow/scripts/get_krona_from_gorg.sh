#!/bin/bash

#reassign variable names

#nodes_dmp=$1
#names_dmp=$2
#cont_ann=$3
#output=$4
#output2=$5

nodes_dmp="/nobackup1/biller/gray/genPride/resources/NCBI/nodes2.dmp"
names_dmp="/nobackup1/biller/gray/genPride/resources/NCBI/names2.dmp"
cont_ann="/nobackup1/biller/gray/genPride/results/gorg_classification/annotations/contigs_annotated.txt"
output="/nobackup1/biller/gray/genPride/results/gorg_krona/gorg_contann.krona"
output2="/nobackup1/biller/gray/genPride/results/gorg_krona/gorg_contann.krona.html"

kaiju2krona -t $nodes_dmp -n $names_dmp -i $cont_ann -o $output -u

ktImportText -o $output $output2
