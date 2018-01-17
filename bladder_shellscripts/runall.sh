source setvars
mkdir $LOG
#This script should reproduce the entire repository, assuming curation is already completed.
./downloadRAW.sh
./downloadPROCESSED.sh
./curation.sh       #only to re-run the curation scripts and re-test the output.
./attach_PROCESSED.sh
./preprocess_AFFY.sh

#Create gene maps from Blast and BioMART.  May be run simultaneously:
$REXEC CMD BATCH --vanilla $SRCHOME/blast_gene_maps.R $LOG/blast_gene_maps.log
$REXEC CMD BATCH --vanilla $SRCHOME/getPlatforms.R $LOG/getPlatforms.log

#Do the mapping.
./bladdergeneMapper.sh
$REXEC CMD BATCH --vanilla $SRCHOME/collapseRows.R $LOG/collapseRows.log

#Move the unmapped and two mapped versions to their own directories.
mkdir $OVHOME/MAPPED/DATA
mkdir $OVHOME/MAPPED/DATA/FULL/
mkdir $OVHOME/MAPPED/DATA/MaxMean/
mkdir $OVHOME/MAPPED/DATA/MaxMean_probesused/
mkdir $OVHOME/MAPPED/DATA/Normalizer/
mv $OVHOME/MAPPED/*FULL.txt $OVHOME/MAPPED/DATA/FULL/
mv $OVHOME/MAPPED/*probesused_MaxMean.txt $OVHOME/MAPPED/DATA/MaxMean_probesused/
mv $OVHOME/MAPPED/*MaxMean.txt $OVHOME/MAPPED/DATA/MaxMean/
mv $OVHOME/MAPPED/*Normalizer.txt $OVHOME/MAPPED/DATA/Normalizer/

##Copy the metadata into one place:
mkdir $OVHOME/MAPPED/DATA/metadata/
find $DATAHOME -name "*_curated_pdata.txt" | xargs -I % cp % $OVHOME/MAPPED/DATA/metadata/

##Finally, create esets:
./createEsets.sh

##Create help pages:
$REXEC CMD BATCH "--args $OVHOME/MAPPED/DATA MaxMean" $SRCHOME/summarizeEset.R $LOG/summarizeEset.Rout
$REXEC CMD BATCH "--args $OVHOME/MAPPED/DATA FULL" $SRCHOME/summarizeEset.R $LOG/summarizeEsetFULL.Rout
$REXEC CMD BATCH "--args $OVHOME/MAPPED/DATA Normalizer" $SRCHOME/summarizeEset.R $LOG/summarizeEsetNormalizer.Rout

./curatedBladderData.sh
