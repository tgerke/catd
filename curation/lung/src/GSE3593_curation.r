rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE3593_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE3593/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#sample_type
#vital_status

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type are all tumor
curated$sample_type <- "tumor"

##vital_status
tmp <- uncurated$characteristics_ch1
tmp[grep("STATUS(0=alive, 1=dead): 1",tmp,fixed=TRUE)] <- "deceased"
tmp[grep("STATUS(0=alive, 1=dead): 0",tmp,fixed=TRUE)] <- "living"
curated$vital_status <- tmp

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE3593_curated_pdata.txt",sep="\t")
