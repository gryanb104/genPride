 #!/bin/python

import os

def write_header(f, sample):
	f.write("SAMPLE: ")
	f.write(sample)
	f.write("\n \n")

def write_manifest_info(f, input_fwd, input_rev, trimmed, paired, ass_meth, gene_pred, clustering_meth, tax_class):
	f.write("FWD READ FILE: "); f.write(input_fwd); f.write("\n" )
	f.write("REV READ FILE: "); f.write(input_rev); f.write("\n \n")
	f.write("INITIAL STATUS"); f.write("\n")
	f.write("    TRIMMED: "); f.write(trimmed); f.write("\n")
	f.write("    PAIRED : "); f.write(paired); f.write("\n \n")
	f.write("METHODS"); f.write("\n")	
	f.write("    ASSEMBLY  : "); f.write(ass_meth); f.write("\n")
	f.write("    GENE PRED : "); f.write(gene_pred); f.write("\n")
	f.write("    CLUSTERING: "); f.write(clustering_meth);f.write("\n")
	f.write("    TAX CLASS : "); f.write(tax_class); f.write("\n")
		
def append_config_yaml(f, sample):
	f.write("CONFIG SETTINGS \n \n")
	with open('config/config.yaml', 'r') as g:
		f.write(g.read())
	
def write_coverage_info(f, coverage_meth, coverage_ref_type, samp_or_path):
	f.write("    COVERAGE  : "); f.write(coverage_meth); f.write("\n")
	if coverage_ref_type == "none":
		f.write("")
	else:
		f.write("      REF TYPE: "); f.write(coverage_ref_type); f.write("\n")
		if coverage_ref_type == "sample":
			f.write("      REF SAMP: "); f.write(samp_or_path); f.write("\n")
			f.write("      REF PATH: "); print_ref_path_samp(samp_or_path, f)
		if coverage_ref_type == "external":
			f.write("      REF PATH: "); f.write(samp_or_path); f.write("\n")
	f.write("\n")

def print_ref_path_samp(samp_or_path,f):
	f.write("results/03-assembled_seqs/")
	f.write(samp_or_path)
	f.write("_assembly/contigs.fasta")
	
def print_ref_path_none(sample,f):
	f.write("results/01-documentation/")
	f.write(sample)
	f.write("_documentation.txt")

def define_covr_inp(sample,samp_doc,ass_contigs_dir,manifest):
	coverage_ref_type = manifest.at[sample,"coverage_reference_type"]
	samp_or_path = manifest.at[sample,"coverage_reference_sample_or_path"]

	if coverage_ref_type == "none":
		return_path = samp_doc
	elif coverage_ref_type == "sample":
		return_path = ass_contigs_dir + samp_or_path + "_assembly/contigs.fasta"
	elif coverage_ref_type == "external":
		return_path = samp_or_path
	else:
		print("INVALID COVERAGE REFERENCE TYPE. PLEASE FIX IN CONFIG/MANIFEST")
	
	return return_path

def define_covr_inp_config(sample,config_file,coverage_ref_type,samp_or_path):
	config_file.write(sample)
	config_file.write("_covr_inp: \"")

	if coverage_ref_type == "none":
		print_ref_path_none(sample,config_file)
	elif coverage_ref_type == "sample":
		print_ref_path_samp(samp_or_path, config_file)
	elif coverage_ref_type == "external":
		config_file.write(manifest.iloc[row]["coverage_reference_sample_or_path"])
	else:
		config_file.write("ERROR")
	config_file.write("\"\n")

def reset_config(config_file,string):
	config_open = open(config_file, "r").read()
	sep = string
	short_new_config = config_open.split(sep, 1)[0]
	os.remove(config_file)
	with open(config_file, "x") as file:
		file.write(short_new_config)
		file.write(string)
		file.write("\n")
		file.write("\n")
	file.close()

#def get_covr_inp(sample):
#	if coverage_ref_type == "sample":
#		samp_or_path=(manifest.iloc[row]["coverage_reference_sample_or_path"])
#		print_ref_path_samp(samp_or_path, f)
#                if coverage_ref_type == "external":
#                        f.write("      REF PATH: ")
#                        f.write(manifest.iloc[row]["coverage_reference_sample_or_path"])
#                f.write("\n")
