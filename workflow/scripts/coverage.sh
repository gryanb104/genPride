#!/bin/bash

paired=$1
covr_inp=$2
sample=$3
output_directory=$4
coverage_method=$5
reads_fwd=$6
reads_rev=$7
output_file=$8

echo "__________________________________________________"
echo ""
echo "COVERAGE REPORT FOR SAMPLE ${sample}"
echo ""
echo "INPUTS:"
echo -n "  paired: "
echo $paired
echo -n "  sample: "
echo $sample
echo -n "  output directory: "
echo $output_directory
echo -n "  coverage method: "
echo $coverage_method
echo -n "  forward reads: "
echo $reads_fwd
echo -n "  reverse reads: "
echo $reads_rev
echo ""
echo "METHODS: "

#set variables
coverage_method_first="$(echo $coverage_method | grep -o '^[^:]*')"
echo "  METHOD ONE: ${coverage_method_first}"
coverage_method_second="$(echo $coverage_method | awk -F ':' '{print $2}')"
echo "  METHOD TWO: ${coverage_method_second}"
coverage_method_third="$(echo $coverage_method | awk -F ':' '{print $3}')"
echo "  METHOD THREE: ${coverage_method_third}"
coverage_method_fourth="$(echo $coverage_method | awk -F ':' '{print $4}')"
echo "  METHOD FOUR: ${coverage_method_fourth}"
echo ""
echo "COVERAGE LOG:"

if [[ $coverage_method_first == "multi-bam" ]]; then
	echo "  SORTING ${reads_fwd} AND ${reads_rev} WITH samtools sort"
	samtools sort $reads_rev -o ${reads_rev}_sorted.bam
	samtools sort $reads_fwd -o ${reads_fwd}_sorted.bam
	echo "  MERGING ${reads_fwd}_sorted.bam AND ${reads_rev}_sorted.bam INTO A SINGLE BAM FILE"
	samtools merge -o ${output_directory}/multi-bam-merge-for-${sample}-coverage.bam ${reads_fwd}_sorted.bam ${reads_rev}_sorted.bam
	echo "  SORTING MERGED BAM FILES USING samtools sort"
	samtools sort ${output_directory}/multi-bam-merge-for-${sample}-coverage.bam -o ${output_directory}/multi-bam-merge-for-${sample}-coverage_sorted.bam
	if [[ $coverage_method_second == "samtools" ]]; then 
		echo "  USING samtools coverage TO CALCULATE COVERAGE FROM COMBINED BAM FILE"
		samtools coverage ${output_directory}/multi-bam-merge-for-${sample}-coverage_sorted.bam -o $output_file
		echo "  USING samtools coverage TO PRODUCE HISTOGRAM OUTPUT"
		if [[ $coverage_method_third != "" ]]; then
			echo "  USING ${coverage_method_third} BINS"
			samtools coverage ${output_directory}/multi-bam-merge-for-${sample}-coverage_sorted.bam --histogram --n-bins ${coverage_method_third} -o ${output_file}_histogram
		else
			echo "  USING DEFAULT BIN NUMBER"
			samtools coverage ${output_directory}/multi-bam-merge-for-${sample}-coverage_sorted.bam --histogram -o ${output_file}_histogram
		fi
	fi
elif [[ $coverage_method_first == "bowtie2" ]]; then
	source ~/.bashrc
	conda deactivate
	export LC_ALL=en_US.utf-8
	export LANG=en_US.utf-8
	conda activate snakeGenPride_py3.10
		
	bowtie2-build $covr_inp ${output_directory}/ref_index_for_${sample}
	bowtie2 -p 8 -x ${output_directory}/ref_index_for_${sample} -1 $reads_fwd -2 $reads_rev | samtools view -bS > ${output_file}.bam
	cp ${output_file}.bam ${output_file}

	conda deactivate
	conda activate snakeGenPride
elif [[ $coverage_method_first == "none"  ]] || [[ $coverage_method_first == "None" ]] || [[ $coverage_method_first == "NONE" ]]; then 
	echo "  NO COVERAGE CALCULATED FOR SAMPLE ${sample}"
	#mkdir $output_directory
        echo "NULL" > $output_file
elif [[ $coverage_method_first == "coverM-from-bam" ]]; then
	#sort the bam files
	samtools sort -n $reads_rev -o ${reads_rev}_sorted
	samtools sort -n $reads_fwd -o ${reads_fwd}_sorted

	#set coverM vars
	coverM_algorithm=$coverage_method_second
	cM_methods=$coverage_method_third
	cM_coverage_mapper=$coverage_method_fourth

	#set defaults and print
	echo "  USING coverM TO CALCULATE COVERAGE FOR SAMPLE ${sample} FROM PREXISTING BAM FILES ${reads_fwd} AND ${reads_rev}"

	##for no coverM algorithm provided
	if [[ $coverM_algorithm == "" ]]; then
		echo "  NO SECOND COVERAGE METHOD PROVIDED. USING coverM genome AS DEFAULT"
		coverM_algorithm="genome"

	##for coverM genome
	elif [[ $coverM_algorithm == "genome" ]]; then
		echo "  USING coverM genome TO CALCULATE COVERAGE"

		###mapper: print and set default
		if [[ $cM_coverage_mapper != "" ]]; then
			echo "  coverM MAPPER ARGUMENT $cM_coverage_mapper IGNORED FOR COVERAGE CALCULATION FROM EXISTING BAM FILES"
		fi

		###coverM method: print and set default
		if [[ $cM_methods == "" ]]; then
			echo "  USING DEFAULT coverM genome METHOD covered_bases"
			cM_methods="covered_bases"
		else
			echo "  USING coverM genome METHOD $cM_methods"
		fi

	##for coverM make
	elif [[ $coverM_algorithm == "make" ]]; then
		echo "  CANNOT USE coverM make ON EXISTING BAM FILES. SEE DOCUMENTATION FOR VALID coverM METHODS."

	##for nonense coverM algorithm provided
	else
		echo "  coverM $coverM_algorithm IS UNSUPPORTED"
	fi

	#run coverM

	##for coverM genome
	if [[ $coverM_algorithm == "genome" ]]; then
		coverm genome --bam-files ${reads_fwd}_sorted ${reads_rev}_sorted --sharded --methods $cM_methods -t 8 -o $output_directory
		#CHANGE NAME
		
	##for nonsense coverM algorithm provided
	else
		echo "  coverM ${coverM_algorithm} IS UNSUPPORTED. SEE DOCUMENTATION FOR SUPPORTED coverM METHODS"
	fi

elif [[ $coverage_method_first == "coverM" ]]; then
	
	#set coverM vars
	coverM_algorithm=$coverage_method_second
	cM_methods=$coverage_method_third
	cM_coverage_mapper=$coverage_method_fourth

	#set defaults and print
	echo "  USING coverM TO CALCULATE COVERAGE FOR SAMPLE ${sample}"

	##for no coverM algorithm provided
	if [[ $coverM_algorithm == "" ]]; then
		echo "  NO SECOND COVERAGE METHOD PROVIDED. USING coverM make AS DEFAULT"
		coverM_algorithm="make"

	##for coverM genome
	elif [[ $coverM_algorithm == "genome" ]]; then
		echo "  USING coverM genome TO CALCULATE COVERAGE"

		###mapper: print and set default
		if [[ $cM_coverage_mapper == "" ]]; then
			echo "  USING DEFAULT MAPPER minimap2-sr"
			coverage_mapper="minimap2-sr"
		else
			echo "  USING COVERAGE MAPPER $cM_coverage_mapper"
		fi

		###coverM method: print and set default
		if [[ $cM_methods == "" ]]; then
			echo "  USING DEFAULT coverM genome METHOD covered_bases"
			cM_methods="covered_bases"
		else
			echo "  USING coverM genome METHOD $cM_methods"
		fi

	##for coverM make
	elif [[ $coverM_algorithm == "make" ]]; then
		echo "  USING coverM make TO CALCULATE COVERAGE"

		###mapper: print and set default
		if [[ $cM_coverage_mapper == "" ]]; then
			echo "  USING DEFAULT MAPPER minimap2-sr"
			coverage_mapper="minimap2-sr"
		else
			echo "  USING COVERAGE MAPPER $cM_coverage_mapper"
		fi

	##for nonense coverM algorithm provided
	else
		echo "  coverM $coverM_algorithm IS UNSUPPORTED"
	fi
	
	#run coverM

	##for coverM genome
	if [[ $coverM_algorithm == "genome" ]]; then
		if [[ $paired == "YES" ]]; then
			coverm genome -1 $reads_fwd -2 $reads_rev --methods $cM_methods -t 8 -r $covr_inp --mapper $cM_coverage_mapper -o $output_directory
			#HERE CHANGE NAME 
		elif [[ $paired == "NO" ]]; then 
			coverm genome --single $reads_fwd --methods $cM_methods -t 8 -r $covr_inp --mapper $cM_coverage_mapper -o $output_directory
			#HERE CHANGE NAME 
		fi

	##for coverM make
	elif [[ $coverM_algorithm == "make" ]]; then
		if [[ $paired == "YES" ]]; then
			coverm make -1 $reads_fwd -2 $reads_rev -t 8 -r $covr_inp --mapper $cM_coverage_mapper -o $output_directory
			cp ${output_directory}/*.bam ${output_file}
		elif [[ $paired == "NO" ]]; then
			coverm make --single $reads_fwd -t 8 -r $covr_inp --mapper $cM_coverage_mapper -o $output_directory
			cp ${output_directory}/*.bam ${output_file}
		fi
  
	##for nonsense coverM algorithm provided
	else
		echo "  coverM ${coverM_algorithm} IS UNSUPPORTED. SEE DOCUMENTATION FOR SUPPORTED coverM METHODS"
	fi

else
	echo "  FIRST COVERAGE METHOD ${coverage_method_first} IS UNSUPPORTED. SEE DOCUMENTATION FOR SUPPORTED COVERAGE METHODS"
fi

echo ""
echo "__________________________________________________"



 
