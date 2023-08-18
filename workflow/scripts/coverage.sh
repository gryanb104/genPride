#!/bin/bash

paired=$1
covr_inp=$2
sample=$3
output_file=$4
coverage_method=$5

coverage_method_first="$(echo $coverage_method | grep -o '^[^:]*')"
coverage_method_second="$(echo $coverage_method | awk -F ':' '{print $2}')"
coverage_method_third="$(echo $coverage_method | awk -F ':' '{print $3}')"
coverage_method_fourth="$(echo $coverage_method | awk -F ':' '{print $4}')"

if [[ $coverage_method == "none" ]]; then
	echo "NO COVERAGE CALCULATED FOR SAMPLE ${sample}"
	echo "NULL" > $output_file
elif [[ $coverage_method_first == "coverM" ]]; then
	reads_fwd="$(grep 'FWD READ FILE: ' $samp_doc | sed 's/^.*: //')"
	reads_rev="$(grep 'REV READ FILE: ' $samp_doc | sed 's/^.*: //')"
	coverage_mapper=$coverage_method_fourth
	if [[ $coverage_mapper == "" ]]; then
		echo "USING DEFAULT MAPPER minimap2-sr"
		coverage_mapper="minimap2-sr"
	else
		echo "USING COVERAGE MAPPER $coverage_mapper"
	fi
	if [[ $paired == "YES" ]]; then
		coverm $coverage_method_second -1 $reads_fwd -2 $reads_rev --methods $coverage_method_third -t 8 -r $covr_inp --mapper $coverage_mapper -o $output_file 
	elif [[ $paired == "NO" ]]; then
		coverm $coverage_method_second --single $reads_fwd --methods $coverage_method_third -t 8 -r $covr_inp --mapper $coverage_mapper -o $output_file	
	fi
	echo "COVERAGE CALCULATED USING COVERAGE METHOD ${coverage_method}"
else
	echo "COVERAGE METHOD ${coverage_method} INVALID"
fi

 
