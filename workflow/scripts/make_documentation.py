#!/bin/python

import sys
import pandas as pd
import os
import workflow/rules/documentation.py as doc

testString = doc.test()
print(testString)

manifest_path = sys.argv[1]
manifest = pd.read_csv(manifest_path)

sample_list = manifest["sample_id"]

for sample in sample_list:
	dir_to_make = os.path.join("results/", sample)
	os.mkdir(dir_to_make)
	file_to_make = sample + "_documentation.txt"
	file_to_make = os.path.join(dir_to_make, file_to_make)

	f = open(file_to_make, "x")
	f.write(sample)
	f.write("\n \n")
	f.write("CONFIG SETTINGS \n \n")
	with open('config/config.yaml', 'r') as g:
    		f.write(g.read())
	f.close()
	




