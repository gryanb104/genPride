#!/bin/python

import sys
import pandas as pd
import os
import shutil
sys.path.append("..")
from ..rules import documentation as doc

manifest_path = sys.argv[1]
manifest = pd.read_csv(manifest_path)
if os.path.isdir("results/01-documentation") == True:
	shutil.rmtree("results/01-documentation")
os.mkdir("results/01-documentation")

sample_list = list(manifest["sample_id"])

for sample in sample_list:
	file_to_make = "results/01-documentation/" + sample + "_documentation.txt"
	f = open(file_to_make, "x")

	doc.write_header(f, sample)
	doc.write_manifest_info(f, sample, sample_list, manifest)
	doc.append_config_yaml(f, sample)
	f.close()
	
print("MAKE DOCUMENTATION: DONE")



