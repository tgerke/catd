source setvars
mkdir $OVHOME/MAPPED

##Agilent
$REXEC CMD BATCH --vanilla "--args GSE17260 $OVHOME/GENEMAPS/efg_agilent_wholegenome_4x44k_v1.csv $DATAHOME/GSE17260/PROCESSED/DEFAULT/GSE17260_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE17260_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE32062-GPL6480 $OVHOME/GENEMAPS/efg_agilent_wholegenome_4x44k_v1.csv $DATAHOME/GSE32062-GPL6480/PROCESSED/DEFAULT/GSE32062-GPL6480_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE32062-GPL6480_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE32063 $OVHOME/GENEMAPS/efg_agilent_wholegenome_4x44k_v1.csv $DATAHOME/GSE32063/PROCESSED/DEFAULT/GSE32063_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE32063_genemapping.log

##Illumina
$REXEC CMD BATCH --vanilla "--args E-MTAB-386 $OVHOME/GENEMAPS/illumina_humanwg_6_v2.csv $DATAHOME/E-MTAB-386/PROCESSED/DEFAULT/E-MTAB-386_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/E-MTAB-386_genemapping.log

##Omit GSE8842 - borderline + early stage, 2-channel.
##$REXEC CMD BATCH --vanilla "--args GSE8842 $OVHOME/GENEMAPS/GSE8842.csv $DATAHOME/GSE8842/PROCESSED/DEFAULT/GSE8842_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE8842_genemapping.log

$REXEC CMD BATCH --vanilla "--args GSE12470 $OVHOME/GENEMAPS/GSE12470.csv $DATAHOME/GSE12470/PROCESSED/DEFAULT/GSE12470_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE12470_genemapping.log

##affy u95a
##We are not using this study.
##$REXEC CMD BATCH --vanilla "--args PMID15505275 $OVHOME/GENEMAPS/affy_hg_u95a.csv $DATAHOME/PMID15505275/PROCESSED/RMA/PMID15505275_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/PMID15505275_genemapping.log

##affy u95av2
##$REXEC CMD BATCH --vanilla "--args GSE19829-GPL8300 $OVHOME/GENEMAPS/affy_hg_u95av2.csv $DATAHOME/GSE19829-GPL8300/PROCESSED/DEFAULT/GSE19829-GPL8300_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE19829-GPL8300_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE19829-GPL8300 $OVHOME/GENEMAPS/affy_hg_u95av2.csv $DATAHOME/GSE19829-GPL8300/PROCESSED/RMA/GSE19829-GPL8300_rma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE19829-GPL8300_genemapping.log

##affy u133_plus_2
##$REXEC CMD BATCH --vanilla "--args GSE19829-GPL570 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE19829-GPL570/PROCESSED/DEFAULT/GSE19829-GPL570_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE19829-GPL570_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE19829-GPL570 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE19829-GPL570/PROCESSED/RMA/GSE19829-GPL570_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE19829-GPL570_genemapping.log

##$REXEC CMD BATCH --vanilla "--args GSE18520 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE18520/PROCESSED/DEFAULT/GSE18520_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE18520_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE18520 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE18520/PROCESSED/RMA/GSE18520_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE18520_genemapping.log

##$REXEC CMD BATCH --vanilla "--args GSE9891 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE9891/PROCESSED/DEFAULT/GSE9891_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE9891_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE9891 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE9891/PROCESSED/RMA/GSE9891_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE9891_genemapping.log

##$REXEC CMD BATCH --vanilla "--args GSE20565 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE20565/PROCESSED/DEFAULT/GSE20565_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE20565_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE20565 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE20565/PROCESSED/RMA/GSE20565_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE20565_genemapping.log

##$REXEC CMD BATCH --vanilla "--args GSE2109 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE2109/PROCESSED/DEFAULT/GSE2109_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE2109_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE2109 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE2109/PROCESSED/RMA/GSE2109_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE2109_genemapping.log
##affy u133a
##$REXEC CMD BATCH --vanilla "--args GSE14764 $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/GSE14764/PROCESSED/DEFAULT/GSE14764_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE14764_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE14764 $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/GSE14764/PROCESSED/RMA/GSE14764_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE14764_genemapping.log

##$REXEC CMD BATCH --vanilla "--args GSE26712 $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/GSE26712/PROCESSED/DEFAULT/GSE26712_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE26712_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE26712 $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/GSE26712/PROCESSED/RMA/GSE26712_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE26712_genemapping.log

##$REXEC CMD BATCH --vanilla "--args GSE6008 $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/GSE6008/PROCESSED/DEFAULT/GSE6008_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE6008_genemapping.log
$REXEC CMD BATCH --vanilla "--args GSE6008 $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/GSE6008/PROCESSED/RMA/GSE6008_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE6008_genemapping.log

$REXEC CMD BATCH --vanilla "--args PMID19318476 $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/PMID19318476/PROCESSED/RMA/PMID19318476_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/PMID19318476_genemapping.log

$REXEC CMD BATCH --vanilla "--args PMID15897565 $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/PMID15897565/PROCESSED/RMA/PMID15897565_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/PMID15897565_genemapping.log

$REXEC CMD BATCH --vanilla "--args PMID17290060 $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/PMID17290060/PROCESSED/RMA/PMID17290060_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/PMID17290060_genemapping.log


##TCGA
$REXEC CMD BATCH --vanilla "--args TCGA $OVHOME/GENEMAPS/affy_hg_u133a.csv $DATAHOME/TCGA/PROCESSED/RMA/TCGA_rma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/TCGA_genemapping.log

##hu6800
$REXEC CMD BATCH --vanilla "--args $OVHOME/GENEMAPS/GSE6822.csv $DATAHOME/GSE6822/PROCESSED/DEFAULT/GSE6822_default_gpl.csv ENTREZ_GENE_ID entrezgene" $SRCHOME/getPlatformsBiomaRt.R $LOG/GSE6822_platform.log
$REXEC CMD BATCH --vanilla "--args GSE6822 $OVHOME/GENEMAPS/GSE6822.csv $DATAHOME/GSE6822/PROCESSED/RMA/GSE6822_rma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE6822_genemapping.log

##custom

$REXEC CMD BATCH --vanilla "--args GSE13876 $OVHOME/GENEMAPS/GSE13876.csv $DATAHOME/GSE13876/PROCESSED/DEFAULT/GSE13876_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE13876_genemapping.log

$REXEC CMD BATCH --vanilla "--args GSE12418 $OVHOME/GENEMAPS/GSE12418.csv $DATAHOME/GSE12418/PROCESSED/DEFAULT/GSE12418_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE12418_genemapping.log

$REXEC CMD BATCH --vanilla "--args $OVHOME/GENEMAPS/GSE30009.csv $DATAHOME/GSE30009/PROCESSED/DEFAULT/GSE30009_default_gpl.csv ORF_LIST hgnc_symbol" $SRCHOME/getPlatformsBiomaRt.R $LOG/GSE30009_platform.log
$REXEC CMD BATCH --vanilla "--args GSE30009 $OVHOME/GENEMAPS/GSE30009.csv $DATAHOME/GSE30009/PROCESSED/DEFAULT/GSE30009_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE30009_genemapping.log


$REXEC CMD BATCH --vanilla "--args TCGA-mirna-8x15kv2 $OVHOME/GENEMAPS/TCGA-mirna-8x15kv2.csv $DATAHOME/TCGA-mirna-8x15kv2/PROCESSED/DEFAULT/TCGA-mirna-8x15kv2_default_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/TCGA-mirna-8x15kv2_genemapping.log


$REXEC CMD BATCH --vanilla "--args GSE30161 $OVHOME/GENEMAPS/affy_hg_u133_plus_2.csv $DATAHOME/GSE30161/PROCESSED/RMA/GSE30161_frma_curated_exprs.txt $OVHOME/MAPPED" $SRCHOME/geneMapper.R $LOG/GSE30161_genemapping.log
