##This script should reproduce the entire repository, assuming curation is already completed and NCBI blast is installed (See README.md in main directory).

source setvars
mkdir $OVHOME/LOG

#Install needed packages:
$REXEC CMD BATCH --vanilla $SRCHOME/install_needed_packages.R $LOG/install_needed_packages.log

./downloadRAW.sh
./downloadPROCESSED.sh
./curation.sh       #only to re-run the curation scripts and re-test the output.
./attach_PROCESSED.sh
./preprocess_AFFY.sh

##Create gene maps from Blast and BioMART.  May be run simultaneously:
$REXEC CMD BATCH --vanilla $SRCHOME/blast_gene_maps.R $LOG/blast_gene_maps.log
$REXEC CMD BATCH --vanilla $SRCHOME/getPlatforms.R $LOG/getPlatforms.log

##Do the mapping.
./geneMapper.sh
$REXEC CMD BATCH --vanilla $SRCHOME/collapseRows.R $LOG/collapseRows.log

##Move the unmapped and two mapped versions to their own directories.
mkdir $OVHOME/MAPPED/DATA
mkdir $OVHOME/MAPPED/DATA/FULL/
mkdir $OVHOME/MAPPED/DATA/MaxMean/
mkdir $OVHOME/MAPPED/DATA/MaxMean_probesused/
mkdir $OVHOME/MAPPED/DATA/Normalizer/
mv $OVHOME/MAPPED/*FULL.txt $OVHOME/MAPPED/DATA/FULL/
mv $OVHOME/MAPPED/*probesused_MaxMean.txt $OVHOME/MAPPED/DATA/MaxMean_probesused/
mv $OVHOME/MAPPED/*MaxMean.txt $OVHOME/MAPPED/DATA/MaxMean/
mv $OVHOME/MAPPED/*Normalizer.txt $OVHOME/MAPPED/DATA/Normalizer/

#Copy the metadata into one place:
mkdir $OVHOME/MAPPED/DATA/metadata/
rm $OVHOME/MAPPED/DATA/metadata/*
#find $DATAHOME -name "*_curated_pdata.txt" | xargs cp --target-dir=$OVHOME/MAPPED/DATA/metadata/
# that works on Macs
find $DATAHOME -name "*_curated_pdata.txt" | xargs -I % cp % $OVHOME/MAPPED/DATA/metadata/

#Finally, create esets:
./createEsets.sh

#create curatedOvarianData package:
./createRpackage.sh
