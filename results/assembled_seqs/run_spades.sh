set -e
true
true
/home/billerlab/software/SPAdes-3.15.5-Linux/bin/spades-hammer /home/billerlab/gray/genPride/results/assembled_seqs/corrected/configs/config.info
/home/billerlab/mambaforge/bin/python /home/billerlab/software/SPAdes-3.15.5-Linux/share/spades/spades_pipeline/scripts/compress_all.py --input_file /home/billerlab/gray/genPride/results/assembled_seqs/corrected/corrected.yaml --ext_python_modules_home /home/billerlab/software/SPAdes-3.15.5-Linux/share/spades --max_threads 20 --output_dir /home/billerlab/gray/genPride/results/assembled_seqs/corrected --gzip_output
true
true
/home/billerlab/software/SPAdes-3.15.5-Linux/bin/spades-core /home/billerlab/gray/genPride/results/assembled_seqs/K21/configs/config.info /home/billerlab/gray/genPride/results/assembled_seqs/K21/configs/mda_mode.info /home/billerlab/gray/genPride/results/assembled_seqs/K21/configs/meta_mode.info
/home/billerlab/software/SPAdes-3.15.5-Linux/bin/spades-core /home/billerlab/gray/genPride/results/assembled_seqs/K33/configs/config.info /home/billerlab/gray/genPride/results/assembled_seqs/K33/configs/mda_mode.info /home/billerlab/gray/genPride/results/assembled_seqs/K33/configs/meta_mode.info
/home/billerlab/software/SPAdes-3.15.5-Linux/bin/spades-core /home/billerlab/gray/genPride/results/assembled_seqs/K55/configs/config.info /home/billerlab/gray/genPride/results/assembled_seqs/K55/configs/mda_mode.info /home/billerlab/gray/genPride/results/assembled_seqs/K55/configs/meta_mode.info
/home/billerlab/mambaforge/bin/python /home/billerlab/software/SPAdes-3.15.5-Linux/share/spades/spades_pipeline/scripts/copy_files.py /home/billerlab/gray/genPride/results/assembled_seqs/K55/before_rr.fasta /home/billerlab/gray/genPride/results/assembled_seqs/before_rr.fasta /home/billerlab/gray/genPride/results/assembled_seqs/K55/assembly_graph_after_simplification.gfa /home/billerlab/gray/genPride/results/assembled_seqs/assembly_graph_after_simplification.gfa /home/billerlab/gray/genPride/results/assembled_seqs/K55/final_contigs.fasta /home/billerlab/gray/genPride/results/assembled_seqs/contigs.fasta /home/billerlab/gray/genPride/results/assembled_seqs/K55/first_pe_contigs.fasta /home/billerlab/gray/genPride/results/assembled_seqs/first_pe_contigs.fasta /home/billerlab/gray/genPride/results/assembled_seqs/K55/strain_graph.gfa /home/billerlab/gray/genPride/results/assembled_seqs/strain_graph.gfa /home/billerlab/gray/genPride/results/assembled_seqs/K55/scaffolds.fasta /home/billerlab/gray/genPride/results/assembled_seqs/scaffolds.fasta /home/billerlab/gray/genPride/results/assembled_seqs/K55/scaffolds.paths /home/billerlab/gray/genPride/results/assembled_seqs/scaffolds.paths /home/billerlab/gray/genPride/results/assembled_seqs/K55/assembly_graph_with_scaffolds.gfa /home/billerlab/gray/genPride/results/assembled_seqs/assembly_graph_with_scaffolds.gfa /home/billerlab/gray/genPride/results/assembled_seqs/K55/assembly_graph.fastg /home/billerlab/gray/genPride/results/assembled_seqs/assembly_graph.fastg /home/billerlab/gray/genPride/results/assembled_seqs/K55/final_contigs.paths /home/billerlab/gray/genPride/results/assembled_seqs/contigs.paths
true
/home/billerlab/mambaforge/bin/python /home/billerlab/software/SPAdes-3.15.5-Linux/share/spades/spades_pipeline/scripts/breaking_scaffolds_script.py --result_scaffolds_filename /home/billerlab/gray/genPride/results/assembled_seqs/scaffolds.fasta --misc_dir /home/billerlab/gray/genPride/results/assembled_seqs/misc --threshold_for_breaking_scaffolds 3
true
