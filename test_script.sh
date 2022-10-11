fwd="/home/billerlab/gray/data_GP/test_fwd.fastq.gz"
bwd="/home/billerlab/gray/data_GP/test_bwd.fastq.gz"
meth="metaspades"
threads=20
spm=250
spades_path="/home/billerlab/software/SPAdes-3.15.5-Linux/bin/"

bash workflow/scripts/assemble_meat.sh $fwd $bwd $meth 0.95 $threads $spm $spades_path

