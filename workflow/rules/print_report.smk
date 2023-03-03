#!/bin/bash

function print_head(){
	name=$1
	echo " "
	echo "                         REPORT FOR RUN"
	echo "                           $name" 
	echo -n "                     genPride method:"; head -1 results/snake_comp.out
	echo " "
	echo "-----------------------------------------------------------------"
}

function calc_filesize(){
	file=$1
	filesize=$(wc -c $file | awk '{print $1}')
        filesize=$(($filesize/1048576))
	echo $filesize
}

function num_seqs(){
	file=$1
	num_of_seqs=$(zcat $fwd_list | echo $((`wc -l`/4)))
	echo $num_of_seqs
}

function print_inp(){
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
