#!/bin/bash

rm1_files=$1

echo "The following output files have been removed from the directory results/assembled_seqs to preserve memory"
echo " "

while read line; do
	line=$(echo "$line" | tr -d ' ')
	if [ "$line" != "" ]; then
		TF=${line#*:}
		if [ $TF == "TRUE" ]; then
			file=${line%%:*}
			rm results/assembled_seqs/$file
			echo $file
		fi
	fi
done < $rm1_files



