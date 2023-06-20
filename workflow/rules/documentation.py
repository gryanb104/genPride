 #!/bin/python

import os

def write_header(f, sample):
	f.write("SAMPLE: ")
	f.write(sample)
	f.write("\n \n")

def write_manifest_info(f, sample, sample_list, manifest):
	row = sample_list.index(sample)

	f.write("FWD READ FILE: ")
	f.write(manifest.iloc[row]["absolute_path_fwd"])
	f.write("\n" )

	f.write("REV READ FILE: ")
	f.write(manifest.iloc[row]["absolute_path_rev"])
	f.write("\n \n")

	f.write("INITIAL STATUS")
	f.write("\n")
	
	f.write("    TRIMMED: ")
	f.write(manifest.iloc[row]["trimmed"])
	f.write("\n")

	f.write("    PAIRED : ")
	f.write(manifest.iloc[row]["paired"])
	f.write("\n \n")

	f.write("METHODS")
	f.write("\n")	

	f.write("    ASSEMBLY  : ")
	f.write(manifest.iloc[row]["assembly"])
	f.write("\n")

	f.write("    GENE PRED : ")
	f.write(manifest.iloc[row]["gene_prediction"])
	f.write("\n")

	f.write("    CLUSTERING: ")
	f.write(manifest.iloc[row]["clustering"])
	f.write("\n")

	f.write("    TAX CLASS : ")
	f.write(manifest.iloc[row]["taxonomic_classifier"])
	f.write("\n")

	write_coverage_info(f, row, manifest, sample)
	
def append_config_yaml(f, sample):
	f.write("CONFIG SETTINGS \n \n")
	with open('config/config.yaml', 'r') as g:
		f.write(g.read())
	
def write_coverage_info(f, row, manifest, sample):
	f.write("    COVERAGE  : ")
	f.write(manifest.iloc[row]["coverage_method"])
	f.write("\n")
	
	coverage_ref_type = manifest.iloc[row]["coverage_reference_type"]
	
	if coverage_ref_type == "none":
		f.write("")
	else:
		f.write("      REF TYPE: ")
		f.write(coverage_ref_type)
		f.write("\n")
		if coverage_ref_type == "sample":
			f.write("      REF SAMP: ")
			samp_or_path=(manifest.iloc[row]["coverage_reference_sample_or_path"])
			f.write(samp_or_path)
			f.write("\n")
			f.write("      REF PATH: ")
			print_ref_path_samp(samp_or_path, f)
		if coverage_ref_type == "external":
			f.write("      REF PATH: ")	
			f.write(manifest.iloc[row]["coverage_reference_sample_or_path"])
		f.write("\n")
	f.write("\n")

def print_ref_path_samp(samp_or_path,f):
	f.write("results/03-assembled_seqs/")
	f.write(samp_or_path)
	f.write("_assembly/contigs.fasta")
	
def print_ref_path_none(sample,f):
	f.write("results/01-documentation/")
	f.write(sample)
	f.write("_documentation.txt")

def define_covr_inp_config(sample,sample_list,config_file,manifest):
	row = sample_list.index(sample)
	coverage_ref_type = manifest.iloc[row]["coverage_reference_type"]
	samp_or_path = (manifest.iloc[row]["coverage_reference_sample_or_path"])

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
	file.close()

#def get_covr_inp(sample):
#	if coverage_ref_type == "sample":
#		samp_or_path=(manifest.iloc[row]["coverage_reference_sample_or_path"])
#		print_ref_path_samp(samp_or_path, f)
#                if coverage_ref_type == "external":
#                        f.write("      REF PATH: ")
#                        f.write(manifest.iloc[row]["coverage_reference_sample_or_path"])
#                f.write("\n")
