source setvars

$REXEC CMD BATCH --vanilla "--args GSE19915 $DATAHOME" $SRCHOME/gse_RAW.R $LOG/GSE19915_downloadRAW.log
$REXEC CMD BATCH --vanilla "--args GSE89 $DATAHOME" $SRCHOME/gse_RAW.R $LOG/GSE89_downloadRAW.log
$REXEC CMD BATCH --vanilla "--args GSE31684 $DATAHOME" $SRCHOME/gse_RAW.R $LOG/GSE31684_downloadRAW.log
$REXEC CMD BATCH --vanilla "--args GSE5287 $DATAHOME" $SRCHOME/gse_RAW.R $LOG/GSE5287_downloadRAW.log
$REXEC CMD BATCH --vanilla "--args GSE32894 $DATAHOME" $SRCHOME/gse_RAW.R $LOG/GSE32894_downloadRAW.log
$REXEC CMD BATCH --vanilla "--args GSE31189 $DATAHOME" $SRCHOME/gse_RAW.R $LOG/GSE31189_downloadRAW.log
$REXEC CMD BATCH --vanilla "--args GSE37317 $DATAHOME" $SRCHOME/gse_RAW.R $LOG/GSE37317_downloadRAW.log

./download_PMID17099711.sh
