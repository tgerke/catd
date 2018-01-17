source setvars
$REXEC CMD BATCH --vanilla "--args ../MAPPED/DATA MaxMean" $SRCHOME/createEsets.R $LOG/createEsets_maxMean.log
$REXEC CMD BATCH --vanilla "--args ../MAPPED/DATA Normalizer" $SRCHOME/createEsets.R $LOG/createEsets_Normalizer.log
$REXEC CMD BATCH --vanilla "--args ../MAPPED/DATA FULL" $SRCHOME/createEsets.R $LOG/createEsets_FULL.log
