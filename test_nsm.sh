sbatch \
--job-name="test_nsm" \
--nodes=1 \
--ntasks=20 \
--mem=250000 \
--time=2-00:00:00 \
--partition="sched_mit_chisholm" \
--exclusive \
workflow/scripts/assemble_meat.sh \
"/home/billerlab/gray/data_GP/test_fwd_tmp.fastq.gz" \
"/home/billerlab/gray/data_GP/test_bwd_tmp.fastq.gz" \
"metaspades" \
0.95 \
20 \
250 \
"/home/billerlab/software/SPAdes-3.15.5-Linux/bin"
