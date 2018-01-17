source setvars

$REXEC CMD BATCH --vanilla "--args GSE5287 $DATAHOME" $SRCHOME/QC.R $LOG/GSE5287_QC.log
$REXEC CMD BATCH --vanilla "--args GSE31684 $DATAHOME" $SRCHOME/QC.R $LOG/GSE31684_QC.log
$REXEC CMD BATCH --vanilla "--args PMID17099711 $DATAHOME" $SRCHOME/QC.R $LOG/PMID17099711_QC.log

#  Too many arrays for QC (expo dataset, many cancers, 2000+ arrays):
# #$REXEC CMD BATCH --vanilla "--args GSE2109 $DATAHOME" $SRCHOME/QC.R $LOG/GSE2109_QC.log
