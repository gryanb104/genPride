#!/bin/bash

samp_doc=$1
covr_inp=$2
sample=$3
output_file=$4
coverage_method="$(grep '    COVERAGE  : ' $samp_doc | sed 's/^.*: //')"

if [[ $coverage_method == "none" ]]; then
	echo "NO COVERAGE CALCULATED FOR SAMPLE ${sample}"
	echo "NULL" > $output_file
elif [[ $coverage_method == "coverM:contigs" ]]; then
	reads_fwd="$(grep 'FWD READ FILE: ' $samp_doc | sed 's/^.*: //')"
	reads_rev="$(grep 'REV READ FILE: ' $samp_doc | sed 's/^.*: //')"
	coverage_mapper="$(grep '      MAPPER  : ' $samp_doc | sed 's/^.*: //')"
	if [[ $coverage_mapper == "" ]]; then
		echo "USING DEFAULT MAPPER minimap2-sr"
		coverage_mapper="minimap2-sr"
	else
		echo "USING COVERAGE MAPPER $coverage_mapper"
	fi
	coverm contig -1 $reads_fwd -2 $reads_rev -t 8 -r $covr_inp --mapper $coverage_mapper -o $output_file 
	echo "COVERAGE CALCULATED USING COVERAGE METHOD ${coverage_method}"
else
	echo "COVERAGE METHOD ${coverage_method} INVALID"
fi

 
