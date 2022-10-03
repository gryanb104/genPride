#!/bin/bash

#set variable names

fwd_list=$1
bwd_list=$2
method=$3
name=$4




#report inputs

#header

echo " "
echo "                     ASSEMBLE REPORT FOR RUN"
echo "                          $name"
echo "_________________________________________________________________"
echo " "


#method
echo "ASSEMBLY METHOD:"
echo "   $method"
echo " "


#inputs
echo "FORWARD READS:"
for file in $fwd_list
do
	echo "   $file" | fold -w 65
done
echo " "
echo "BACKWARD READS:"
for file in $bwd_list
do
	echo "   $file" | fold -w 65
done
echo " "
echo "_________________________________________________________________"
echo " "

#report meat

echo "TOTAL ASSEMBLY TIME:"
echo "       $SECONDS"
echo " "
echo "ASSEMBLY TIME PER READ:"
echo "        time per here"
echo " "
#
