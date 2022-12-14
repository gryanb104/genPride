#!/bin/bash

rm2_files=$1

echo "The following output files have been removed from the directory results/clustered_seqs and results/cluster_tmp to preserve memory"
echo " "

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
done < $rm2_files



