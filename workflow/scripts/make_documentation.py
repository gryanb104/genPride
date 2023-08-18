#!/bin/python

import sys
import pandas as pd
import os
import shutil
sys.path.append("..")
from ..rules import documentation as doc

input_fwd = sys.argv[1]
config_file = sys.argv[2]
input_rev = sys.argv[3]
sample = sys.argv[4]
samp_doc_dir = sys.argv[6]
trimmed = sys.argv[5]
samp_or_path = sys.argv[7]
paired = sys.argv[8]
ass_meth = sys.argv[9]
gene_pred = sys.argv[10]
clustering_meth = sys.argv[11]
tax_class = sys.argv[12]
coverage_meth = sys.argv[13]
coverage_ref_type = sys.argv[14]
samp_doc = sys.argv[15]

if os.path.isdir(samp_doc_dir) == False:
	os.mkdir(samp_doc_dir)

file_to_make = samp_doc
f = open(file_to_make, "x")
doc.write_header(f, sample)
doc.write_manifest_info(f, input_fwd, input_rev, trimmed, paired, ass_meth, gene_pred, clustering_meth, tax_class)
doc.write_coverage_info(f, coverage_meth, coverage_ref_type, samp_or_path)
doc.append_config_yaml(f, sample)
f.close()

config_file = open(config_file, "a")
doc.define_covr_inp_config(sample,config_file,coverage_ref_type,samp_or_path)
config_file.close()

print("MAKE DOCUMENTATION: DONE")


