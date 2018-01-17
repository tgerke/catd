source setvars
$REXEC CMD BATCH --vanilla "--args GSE14764 $DATAHOME $CURATED/GSE14764_curated_pdata.txt $QC/GSE14764_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE14764_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args GSE20565 $DATAHOME $CURATED/GSE20565_curated_pdata.txt $QC/GSE20565_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE20565_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args GSE6008 $DATAHOME $CURATED/GSE6008_curated_pdata.txt $QC/GSE6008_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE6008_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args GSE18520 $DATAHOME $CURATED/GSE18520_curated_pdata.txt $QC/GSE18520_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE18520_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args GSE26712 $DATAHOME $CURATED/GSE26712_curated_pdata.txt $QC/GSE26712_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE26712_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args GSE6822 $DATAHOME $CURATED/GSE6822_curated_pdata.txt $QC/GSE6822_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE6822_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args GSE9891 $DATAHOME $CURATED/GSE9891_curated_pdata.txt $QC/GSE9891_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE9891_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args GSE2109 $DATAHOME $CURATED/GSE2109_curated_pdata.txt $QC/GSE2109_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE2109_preprocess_AFFY.log

$REXEC CMD BATCH --vanilla "--args GSE19829-GPL570 $DATAHOME $CURATED/GSE19829-GPL570_curated_pdata.txt $QC/GSE19829-GPL570_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE19829-GPL570_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args GSE19829-GPL8300 $DATAHOME $CURATED/GSE19829-GPL8300_curated_pdata.txt $QC/GSE19829-GPL8300_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE19829-GPL8300_preprocess_AFFY.log

$REXEC CMD BATCH --vanilla "--args PMID15897565 $DATAHOME $CURATED/PMID15897565_curated_pdata.txt $QC/PMID15897565_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/PMID15897565_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args PMID19318476 $DATAHOME $CURATED/PMID19318476_curated_pdata.txt $QC/PMID19318476_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/PMID19318476_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args PMID17290060 $DATAHOME $CURATED/PMID17290060_curated_pdata.txt $QC/PMID17290060_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/PMID17290060_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args TCGA $DATAHOME $CURATED/TCGA_curated_pdata.txt $QC/TCGA_excludedsamples.txt rma" $SRCHOME/preprocess_AFFY.R $LOG/TCGA_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args GSE30161 $DATAHOME $CURATED/GSE30161_curated_pdata.txt $QC/GSE30161_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE30161_preprocess_AFFY.log
