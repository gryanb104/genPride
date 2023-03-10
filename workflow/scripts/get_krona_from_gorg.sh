#!/bin/bash

#reassign variable names

nodes_dmp=$1
names_dmp=$2
cont_ann=$3
output=$4

start=$SECONDS

kaiju2krona -t $nodes_dmp -n $names_dmp -i $cont_ann -o $output -u
echo "krona rep"

duration=$(( SECONDS - start ))

echo "time(sec):"
echo -n $duration
