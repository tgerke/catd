#!/bin/bash

source setvars

URL="https://tcga-data.nci.nih.gov/tcgafiles/ftp_auth/distro_ftpusers/anonymous/tumor/ov/cgcc/broad.mit.edu/ht_hg-u133a/transcriptome"

strInputAccession="TCGA"
strBaseDir=$DATAHOME
celDir=$strBaseDir/$strInputAccession
processedDir=$celDir/PROCESSED
defaultDir=$processedDir/DEFAULT


mkdir $strBaseDir
mkdir $celDir
mkdir $celDir/RAW
mkdir $processedDir
mkdir $defaultDir

cd $celDir/RAW

wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.11.1004.0.tar.gz
wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.12.1004.0.tar.gz
wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.13.1004.0.tar.gz
wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.14.1004.0.tar.gz
wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.15.1004.0.tar.gz
wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.17.1004.0.tar.gz
wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.18.1004.0.tar.gz
wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.19.1004.0.tar.gz
wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.21.1004.0.tar.gz
wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.22.1004.0.tar.gz
wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.24.1004.0.tar.gz
wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.27.1004.0.tar.gz
wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.40.1004.0.tar.gz
wget --timestamping $URL/broad.mit.edu_OV.HT_HG-U133A.Level_1.9.1004.0.tar.gz 

for file in `ls *.tar.gz`;do tar xfz $file;done
find . -name "*.CEL" > TCGA_file_sources.txt
for file in `find . -name "*.CEL"`;do mv $file .;done
rm -f *.tar.gz

