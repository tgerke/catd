source setvars

$REXEC CMD BATCH --vanilla "--args GSE5287 $DATAHOME $CURATED/GSE5287_curated_pdata.txt $QC/GSE5287_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE5287_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args GSE37317 $DATAHOME $CURATED/GSE37317_curated_pdata.txt $QC/GSE37317_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE37317_preprocess_AFFY.log

$REXEC CMD BATCH --vanilla "--args GSE31684 $DATAHOME $CURATED/GSE31684_curated_pdata.txt $QC/GSE31684_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE31684_preprocess_AFFY.log
$REXEC CMD BATCH --vanilla "--args GSE31189 $DATAHOME $CURATED/GSE31189_curated_pdata.txt $QC/GSE31189_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE31189_preprocess_AFFY.log

$REXEC CMD BATCH --vanilla "--args GSE89 $DATAHOME $CURATED/GSE89_curated_pdata.txt $QC/GSE89_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/GSE89_preprocess_AFFY.log

$REXEC CMD BATCH --vanilla "--args PMID17099711-GPL91 $DATAHOME $CURATED/PMID17099711-GPL91_curated_pdata.txt $QC/PMID17099711-GPL91_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/PMID17099711-GPL91_preprocess_AFFY.log

$REXEC CMD BATCH --vanilla "--args PMID17099711-GPL8300 $DATAHOME $CURATED/PMID17099711-GPL8300_curated_pdata.txt $QC/PMID17099711-GPL8300_excludedsamples.txt" $SRCHOME/preprocess_AFFY.R $LOG/PMID17099711-GPL8300_preprocess_AFFY.log

