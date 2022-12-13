#!/bin/bash

rm1_files=$1

while read line; do
	if [ "$line" != "" ]; then
		echo -e "$line"
	fi
done < $rm1_files



