#!/bin/bash

function print_head(){ #print report header
	name=$1; sample=$2
	echo " "
	echo "                               REPORT"
	echo "                         RUN NAME: $name" 
	echo "                      SAMPLE NAME: $sample"
	echo " "
	echo "-----------------------------------------------------------------"
}

function calc_filesize(){ #calculate the size of a file in MB
	file=$1
	filesize=$(wc -c $file | awk '{print $1}')
        filesize=$(($filesize/1048576))
	echo $filesize
}

function num_seqs(){ #determine the number of sequences in a fastq file
	file=$1
	num_of_seqs=$(zcat $fwd_list | echo $((`wc -l`/4)))
	echo $num_of_seqs
}

function print_inp(){ #print input information report
	fwd_list=$1; bwd_list=$2
	filesize_fwd=$(calc_filesize $fwd_list)
	filesize_bwd=$(calc_filesize $bwd_list)
	seqs_start_fwd=$(num_seqs $fwd_list)
	echo " "
	echo "                            INPUTS"
	echo "FORWARD READS INPUT"
	echo "  FRWRD READS FILE : ${fwd_list##*/}"
	echo -n "  SIZE OF FWD FILE : $filesize_fwd"; echo " MB"
	echo "REVERSE READS INPUT"
	echo "  RVRSE READS FILE : ${bwd_list##*/}"
	echo -n "  SIZE OF BWD FILE : $filesize_bwd"; echo " MB"
	echo "NUMBER INPUT READS : $seqs_start_fwd"
	echo " "
	echo "-----------------------------------------------------------------"
}

function secs_to_time(){ #convert seconds to hours, mins, secs
	sec=$1
	min=$(($sec / 60)); only_sec=$(($sec - ($min * 60)))
	hour=$(($sec / 3600)); only_min=$(($min - ($hour * 60)))
	echo -n $hour; echo -n "h $only_min"; echo -n "m $only_sec"; echo "s"
}

function contig_num_from_quast(){
	report_path=$1
	num_contigs=$(grep "# contigs    " $report_path | awk '{print $3}')
	echo $num_contigs
}

function print_assembly(){
	ass_contigs=$1; slurm_ass=$2; fwd_list=$3; meth=$4; sample=$5; report_path=$6
	filesize_ass=$(calc_filesize $ass_contigs)
	seqs_start_fwd=$(num_seqs $fwd_list)
	sec=$(tail -n 1 $slurm_ass)
	time=$(secs_to_time $sec)
	num_contigs=$(contig_num_from_quast $report_path)
	sec_f=$(printf "%f\n" $((10**6 * $sec/$seqs_start_fwd))e-6)
	sec_c=$(printf "%f\n" $((10**6 * $sec/$num_contigs))e-6)

	echo " "
	echo "                           ASSEMBLY"
	echo "ASSEMBLY METHOD GP : $meth"
	echo -n "SIZE OF CONTG FILE : "; echo -n $filesize_ass; echo " MB"
	echo "ASSEMBLY TIME"
	echo "  TOT TIME ELAPSED : $time"
	echo "  TOT TIME IN SECS : $sec"
	echo -n "  T PER INPUT READ : $sec_f"; echo "s"
	echo -n "  T PER OUT CONTIG : $sec_c"; echo "s"
	echo " "
	echo "-----------------------------------------------------------------"
}

function get_report_path() {
	sample=$1
	if [ ! -d "results/03b-quast_out/${sample}_quast/combined_reference" ]
	then
		rep_path="results/03b-quast_out/${sample}_quast/report.txt"
	else
		rep_path="results/03b-quast_out/${sample}_quast/combined_reference/report.txt"
	fi
	echo $rep_path
}

