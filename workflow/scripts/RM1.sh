#!/bin/bash

rm1_files=$1
sample=$2
dir=$3

echo "The following output files have been removed from the directory results/02-assembled_seqs/${sample}_assembly to preserve memory"
echo " "

while read line; do
	line=$(echo "$line" | tr -d ' ')
	if [ "$line" != "" ]; then
		TF=${line#*:}
		if [ $TF == "TRUE" ]; then
			file=${line%%:*}
			rm ${dir}/${sample}_assembly/$file
			echo $file
		fi
	fi
done < $rm1_files



