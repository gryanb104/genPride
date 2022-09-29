#!/bin/bash

#set variable names

fwd_list=$1
bwd_list=$2
method=$3
#name=$4

#report inputs

#header

echo "                                     "
echo "       ASSEMBLE REPORT FOR RUN       "
#echo "            $name         "
echo "_____________________________________"
echo "                                     "


#method
echo "ASSEBLY METHOD: $method" 
echo "                                     "


#inputs
echo "FORWARD READS:"
for file in $fwd_list
do
	echo "   $file"
done
echo "                                     "
echo "BACKWARD READS:                      "
for file in $bwd_list
do
	echo "   $file"
done



#
