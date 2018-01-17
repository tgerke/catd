#!/bin/bash

source setvars

URL="https://tcga-data.nci.nih.gov/tcgafiles/ftp_auth/distro_ftpusers/anonymous/tumor/ov/cgcc/unc.edu/h-mirna_8x15kv2/mirna"
strInputAccession="TCGA-mirna-8x15kv2"
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

wget --timestamping --no-check-certificate $URL/unc.edu_OV.H-miRNA_8x15Kv2.Level_3.1.8.0.tar.gz

for file in `ls *.tar.gz`;do tar xfz $file;done
find . -name "*.data.txt" > TCGA-mirna-8x15kv2_file_sources.txt
for file in `find . -name "*.data.txt"`;do mv $file .;done
rm -f *.tar.gz

RCODE="
    files = dir(full.names=TRUE);
    files = files[grep(\".data.txt\", files)];
    data <- lapply(files, read.delim, stringsAsFactors=FALSE, row.names=1,
    as.is=TRUE);
    cdata <- do.call(cbind, data)[-1,];
    write.csv(cdata, file=\"TCGA-mirna-8x15kv2_default_exprs.csv\",
    quote=FALSE);
    write.csv(data.frame(probeset=rownames(cdata),hgnc=rownames(cdata)),
    file=\"TCGA-mirna-8x15kv2.csv\",
    quote=FALSE,row.names=FALSE);
    "

TMPFILE=`mktemp`
echo $RCODE > "$TMPFILE"
R --vanilla < "$TMPFILE"
mv TCGA-mirna-8x15kv2_default_exprs.csv $defaultDir
mkdir $OVHOME/GENEMAPS
mv TCGA-mirna-8x15kv2.csv $OVHOME/GENEMAPS

