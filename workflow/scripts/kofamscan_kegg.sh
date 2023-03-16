#!/bin/bash

output=$1
ko_db_profile=$2
kegg_cpu=$3
temp_dir=$4
e_val=$5
format=$6
thresh_scale=$7
hmmsearch=$8
parallel=$9
aa_file=${10}
exec_dir=${11}
ko_list=${12}

source workflow/rules/kegg_ann.smk

make_kegg_config $ko_db_profile $ko_list $hmmsearch $parallel $kegg_cpu > ${exec_dir}/config.yml 





