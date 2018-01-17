source setvars
$REXEC CMD BATCH --vanilla "--args ../MAPPED/DATA MaxMean ../etc/bladder_cancer_public_datasets.csv" $SRCHOME/createEsets.R $LOG/createEsets_maxMean.log
$REXEC CMD BATCH --vanilla "--args ../MAPPED/DATA Normalizer ../etc/bladder_cancer_public_datasets.csv" $SRCHOME/createEsets.R $LOG/createEsets_Normalizer.log
$REXEC CMD BATCH --vanilla "--args ../MAPPED/DATA FULL ../etc/bladder_cancer_public_datasets.csv" $SRCHOME/createEsets.R $LOG/createEsets_FULL.log
