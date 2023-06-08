#!/bin/bash

rm2_files=$1
sample=$2

echo "The following output files have been removed from the directory results/05-clustered_seqs/${sample}_cluster"
echo "and results/05-clustered_seqs/${sample}_cluster/cluster_tmp to preserve memory"
echo " "

sed "s/SAMPLE/${sample}/g" $rm2_files > config/tmp_rm2.txt

while read line; do
	line=$(echo "$line" | tr -d ' ')
	if [ "$line" != "" ]; then
		TF=${line#*:}
		if [ $TF == "TRUE" ]; then
			file=${line%%:*}
			rm results/$file
			echo $file
		fi
	fi
done < config/tmp_rm2.txt

rm config/tmp_rm2.txt

