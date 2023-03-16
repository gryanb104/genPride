function make_kegg_config(){
	ko_db_profile=$1
	ko_list=$2
	hmmsearch=$3
	parallel=$4
	kegg_cpu=$5
	echo "profile: $ko_db_profile"
	echo " "
	echo "ko_list: $ko_list" 
	echo " "
	echo "hmmsearch: $hmmsearch"
	echo " "
	echo "parallel: $parallel"
	echo " "
	echo "cpu: $kegg_cpu"
}
