#!/bin/python

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

	f.write("    COVERAGE  : ")
	f.write(manifest.iloc[row]["coverage"])
	f.write("\n \n")

def append_config_yaml(f, sample):
	f.write("CONFIG SETTINGS \n \n")
	with open('config/config.yaml', 'r') as g:
		f.write(g.read())
	
