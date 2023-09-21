#!/bin/bash

paired=$1
covr_inp=$2
sample=$3
output_file=$4
coverage_method=$5
reads_fwd=$6
reads_rev=$7

source workflow/rules/coverage.smk

#set variables

coverage_method_first="$(echo $coverage_method | grep -o '^[^:]*')"
coverage_method_second="$(echo $coverage_method | awk -F ':' '{print $2}')"
coverage_method_third="$(echo $coverage_method | awk -F ':' '{print $3}')"
coverage_method_fourth="$(echo $coverage_method | awk -F ':' '{print $4}')"

if [[ $coverage_method == "none" ]]; then 
	cvr_is_none $sample $output_file
elif [[ $coverage_method_first == "coverM" ]]; then
	
	#set coverM vars
	coverM_algorithm=$coverage_method_second
	cM_methods=$coverage_method_third
	cM_coverage_mapper=$coverage_method_fourth

	#set defaults and print
	echo ""
	echo "USING coverM TO CALCULATE COVERAGE FOR SAMPLE ${sample}"

	##for no coverM algorithm provided
	if [[ $coverM_algorithm == "" ]]; then
		echo "NO SECOND COVERAGE METHOD PROVIDED. USING coverM make AS DEFAULT"
		coverM_algorithm="make"

	##for coverM genome
	elif [[ $coverM_algorithm == "genome" ]]; then
		echo "USING coverM genome TO CALCULATE COVERAGE"

		###mapper: print and set default
		if [[ $cM_coverage_mapper == "" ]]; then
			echo "USING DEFAULT MAPPER minimap2-sr"
			coverage_mapper="minimap2-sr"
		else
			echo "USING COVERAGE MAPPER $cM_coverage_mapper"; fi

		###coverM method: print and set default
		if [[ $cM_methods == "" ]]; then
			echo "USING DEFAULT coverM genome METHOD covered_bases"
			cM_methods="covered_bases"
		else
			echo "USING coverM genome METHOD $cM_methods"; fi

	##for coverM make
	elif [[ $coverM_algorithm == "make" ]]; then
                echo "USING coverM make TO CALCULATE COVERAGE"

                ###mapper: print and set default
                if [[ $cM_coverage_mapper == "" ]]; then
                        echo "USING DEFAULT MAPPER minimap2-sr"
                        coverage_mapper="minimap2-sr"
                else
                        echo "USING COVERAGE MAPPER $cM_coverage_mapper"; fi

	##for nonense coverM algorithm provided
	else
		echo "coverM $coverM_algorithm IS UNSUPPORTED"; fi
	
	#run coverM

	##for coverM genome
	if [[ $coverM_algorithm == "genome" ]]; then
		if [[ $paired == "YES" ]]; then
			coverm genome -1 $reads_fwd -2 $reads_rev --methods $cM_methods -t 8 -r $covr_inp --mapper $cM_coverage_mapper -o $output_file 
		elif [[ $paired == "NO" ]]; then 
			coverm genome --single $reads_fwd --methods $cM_methods -t 8 -r $covr_inp --mapper $cM_coverage_mapper -o $output_file; fi

	##for coverM make
	elif [[ $coverM_algorithm == "make" ]]; then
		if [[ $paired == "YES" ]]; then
			coverm make -1 $reads_fwd -2 $reads_rev -t 8 -r $covr_inp --mapper $cM_coverage_mapper -o $output_file
		elif [[ $paired == "NO" ]]; then
			coverm make --single $reads_fwd -t 8 -r $covr_inp --mapper $cM_coverage_mapper -o $output_file; fi

	##for nonsense coverM algorithm provided
	else
		echo "coverM ${coverM_algorithm} IS UNSUPPORTED. SEE DOCUMENTATION FOR SUPPORTED coverM METHODS"; fi
else
	echo "FIRST COVERAGE METHOD ${coverage_method_first} IS UNSUPPORTED. SEE DOCUMENTATION FOR SUPPORTED COVERAGE METHODS"; fi





 
