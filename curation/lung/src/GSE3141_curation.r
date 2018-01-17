rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE3141_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE3141/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#sample_type
#histology
#days_to_death
#vital_status

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type are all tumor
curated$sample_type <- "tumor"

##histology
tmp <- uncurated$characteristics_ch1
tmp[grep("Cell type: S",tmp,fixed=TRUE)] <- "sq"
tmp[grep("Cell type: A",tmp,fixed=TRUE)] <- "ad"
curated$histology <- tmp

##days_to_death
tmp <- uncurated$characteristics_ch1
#tmp <- sub(".*Surv(months): (\\d),.*", "\\1", tmp)
tmp <- gsub("[]","",tmp,perl=TRUE)
curated$days_to_death <- tmp

##vital_status
tmp <- uncurated$characteristics_ch1
tmp[grep("STATUS(0=alive, 1=dead): 1",tmp,fixed=TRUE)] <- "deceased"
tmp[grep("STATUS(0=alive, 1=dead): 0",tmp,fixed=TRUE)] <- "living"
curated$vital_status <- tmp

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE3141_curated_pdata.txt",sep="\t")
