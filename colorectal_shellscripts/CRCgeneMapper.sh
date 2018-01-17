source setvars
mkdir $OVHOME/MAPPED

#Note, I only did this for CRC platforms that we used for ovarian as well.  
#See compare crc/ovarian excel file for further info.

##affy u133_plus_2
##$REXEC CMD BATCH --vanilla "--args GSE4526 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE4526/PROCESSED/DEFAULT/GSE4526_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE4526_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE4526 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE4526/PROCESSED/RMA/GSE4526_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE4526_genemapping.log

##$REXEC CMD BATCH --vanilla "--args GSE13067 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE13067/PROCESSED/DEFAULT/GSE13067_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE13067_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE13067 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE13067/PROCESSED/RMA/GSE13067_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE13067_genemapping.log

##$REXEC CMD BATCH --vanilla "--args GSE14333 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE14333/PROCESSED/DEFAULT/GSE14333_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE14333_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE14333 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE14333/PROCESSED/RMA/GSE14333_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE14333_genemapping.log

##$REXEC CMD BATCH --vanilla "--args GSE17536 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE17536/PROCESSED/DEFAULT/GSE17536_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE17536_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE17536 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE17536/PROCESSED/RMA/GSE17536_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE17536_genemapping.log


##$REXEC CMD BATCH --vanilla "--args GSE17537 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE17537/PROCESSED/DEFAULT/GSE17537_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE17537_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE17537 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE17537/PROCESSED/RMA/GSE17537_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE17537_genemapping.log


##$REXEC CMD BATCH --vanilla "--args GSE18105 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE18105/PROCESSED/DEFAULT/GSE18105_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE18105_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE18105 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE18105/PROCESSED/RMA/GSE18105_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE18105_genemapping.log

##$REXEC CMD BATCH --vanilla "--args GSE21510 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE21510/PROCESSED/DEFAULT/GSE21510_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE21510_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE21510 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE21510/PROCESSED/RMA/GSE21510_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE21510_genemapping.log

##$REXEC CMD BATCH --vanilla "--args GSE26906 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE26906/PROCESSED/DEFAULT/GSE26906_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE26906_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE26906 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE26906/PROCESSED/RMA/GSE26906_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE26906_genemapping.log

##affy u133a
##$REXEC CMD BATCH --vanilla "--args GSE4045 $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/GSE4045/PROCESSED/DEFAULT/GSE4045_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE4045_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE4045 $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/GSE4045/PROCESSED/RMA/GSE4045_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE4045_genemapping.log

##$REXEC CMD BATCH --vanilla "--args GSE12945 $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/GSE12945/PROCESSED/DEFAULT/GSE12945_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE12945_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE12945 $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/GSE12945/PROCESSED/RMA/GSE12945_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE12945_genemapping.log

##affy u95av2
##$REXEC CMD BATCH --vanilla "--args GSE11237 $OVHOME/GENEMAPS/affy_hg_u95av2.csv $DATAHOME/GSE11237/PROCESSED/DEFAULT/GSE11237_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE11237_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE11237 $OVHOME/GENEMAPS/affy_hg_u95av2.csv $DATAHOME/GSE11237/PROCESSED/RMA/GSE11237_rma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE11237_genemapping.log
