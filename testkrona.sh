#!/bin/bash

nodes_dmp="/nobackup1/biller/gray/genPride/resources/NCBI/nodes2.dmp"
names_dmp="/nobackup1/biller/gray/genPride/resources/NCBI/names2.dmp"
cont_ann="/nobackup1/biller/gray/genPride/results/gorg_classification/annotations"
output="/nobackup1/biller/gray/genPride/results/gorg_krona/gorg_contann.krona"
output2="/nobackup1/biller/gray/genPride/results/gorg_krona/gorg_contann.krona.html"

workflow/scripts/get_krona_from_gorg.sh $nodes_dmp $names_dmp $cont_ann $output $output2
