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

## Non-GEO datasets have their microarray platform set manually (by GPL code from GEO):
echo "starting with TCGA"
$REXEC CMD BATCH --vanilla "--args TCGA $DATAHOME GPL3921 $DATAHOME/TCGA/PROCESSED/RMA/TCGA_rma_exprs.csv $DATAHOME/TCGA/PROCESSED/RMA/TCGA_rma_exprs_HGNC.csv $DATAHOME $DATAHOME/TCGA/PROCESSED/DEFAULT/TCGA_default_gpl.csv $DATAHOME/TCGA/PROCESSED/RMA/TCGA_rma_exprs.csv $DATAHOME/TCGA/PROCESSED/RMA/TCGA_rma_exprs_HGNC.csv" $SRCHOME/geneMapper.R $LOG/TCGA_geneMapper.log

echo "starting with PMID17290060"
$REXEC CMD BATCH --vanilla "--args PMID17290060 $DATAHOME GPL96 $DATAHOME/PMID17290060/PROCESSED/RMA/PMID17290060_frma_exprs.csv $DATAHOME/PMID17290060/PROCESSED/RMA/PMID17290060_frma_exprs_HGNC.csv" $SRCHOME/geneMapper.R $LOG/GSE12418_geneMapper.log

echo "starting with PMID19318476"
$REXEC CMD BATCH --vanilla "--args PMID19318476 $DATAHOME GPL96 $DATAHOME/PMID19318476/PROCESSED/RMA/PMID19318476_frma_exprs.csv $DATAHOME/PMID19318476/PROCESSED/RMA/PMID19318476_frma_exprs_HGNC.csv" $SRCHOME/geneMapper.R $LOG/GSE12418_geneMapper.log
