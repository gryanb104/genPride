#!/bin/bash
#SBATCH --job-name=genPride		#job name
#SBATCH --nodes=1			#number of nodes to use
#SBATCH --ntasks=20			#number of cpus to use
#SBATCH --mem=250000			#maximum memory
#SBATCH --time=2-00:00:00		#maximum time to run
#SBATCH --partition=sched_mit_chisholm	#partition name
#SBATCH --exclusive			#exclusive use of node

method=$1

cd /nobackup1/billerlab/gray/genPride

declare -A sf_dict
sf_dict['heli']='workflow/Snakefile_heli'
sf_dict['prune']='workflow/Snakefile_prune'
sf_dict['nut']='workflow/Snakefile_nut' 
sf_dict['cinnamon']='workflow/Snakefile_cinnamon'
sf_dict['copter']='workflow/Snakefile_copter'
sf_dict['apricot']='workflow/Snakefile_apricot'
sf_dict['coconut']='workflow/Snakefile_coconut'
sf_dict['spice']='workflow/Snakefile_spice'

place=${sf_dict[$method]}
cp $place workflow/Snakefile

#snakemake --snakefile $SNAKEFILE --lint
#snakemake --snakefile $SNAKEFILE --unlock
#snakefmt $SNAKEFILE

snakemake --cores 1
