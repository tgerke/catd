##Script for generic gene mapping, using whatever platform file (GPL)
##was downloaded from GEO.

source setvars

echo "===============fRMA====================="
for file in `ls $DATAHOME`
do
LOGFILE=$LOG/"$file"_frma_geneMapper.log
ARG1=$file
ARG2=$DATAHOME/"$file"/PROCESSED/DEFAULT/"$file"_default_gpl.csv
ARG3=$DATAHOME/"$file"/PROCESSED/RMA/"$file"_frma_exprs.csv
ARG4=$DATAHOME/"$file"/PROCESSED/RMA/"$file"_frma_exprs_HGNC.csv
echo "starting with $file"
/usr/local/bin/R CMD BATCH --vanilla "--args $file $ARG1 $ARG2 $ARG3 $ARG4" $SRCHOME/geneMapper.R $LOGFILE
done

echo "===============RMA====================="
for file in `ls $DATAHOME`
do
LOGFILE=$LOG/"$file"_rma_geneMapper.log
ARG1=$file
ARG2=$DATAHOME/"$file"/PROCESSED/DEFAULT/"$file"_default_gpl.csv
ARG3=$DATAHOME/"$file"/PROCESSED/RMA/"$file"_rma_exprs.csv
ARG4=$DATAHOME/"$file"/PROCESSED/RMA/"$file"_rma_exprs_HGNC.csv
echo "starting with $file"
/usr/local/bin/R CMD BATCH --vanilla "--args $file $ARG1 $ARG2 $ARG3 $ARG4" $SRCHOME/geneMapper.R $LOGFILE
done


echo "===============DEFAULT====================="
for file in `ls $DATAHOME`
do
LOGFILE=$LOG/"$file"_default_geneMapper.log
ARG1=$file
ARG2=$DATAHOME/"$file"/PROCESSED/DEFAULT/"$file"_default_gpl.csv
ARG3=$DATAHOME/"$file"/PROCESSED/DEFAULT/"$file"_default_exprs.csv
ARG4=$DATAHOME/"$file"/PROCESSED/DEFAULT/"$file"_default_exprs_HGNC.csv
echo "starting with $file"
/usr/local/bin/R CMD BATCH --vanilla "--args $file $ARG1 $ARG2 $ARG3 $ARG4" $SRCHOME/geneMapper.R $LOGFILE
done

