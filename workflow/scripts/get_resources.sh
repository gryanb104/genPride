#!/bin/bash

#get kofamscan

wget ftp://ftp.genome.jp/pub/db/kofam/ko_list.gz
wget ftp://ftp.genome.jp/pub/db/kofam/profiles.tar.gz 
wget ftp://ftp.genome.jp/pub/tools/kofamscan/kofamscan.tar.gz
wget ftp://ftp.genome.jp/pub/tools/kofamscan/README.md

gunzip ko_list.gz
tar xf profiles.tar.gz
tar xf kofamscan.tar.gz



