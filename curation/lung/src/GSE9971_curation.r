rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE9971_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE9971/RAW"

##initial creation of curated dataframe

curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#recurrence_status
#histology


#alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

#recurrence_status
tmp <- uncurated$source_name_ch1
tmp[tmp=="recurrent NSCLC tumor"] <- "recurrence"
tmp[tmp=="non-recurrent NSCLC tumor"] <- "norecurrence"
curated$recurrence_status <- tmp

#histology
curated$histology <- "nsclc_nos"

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE9971_curated_pdata.txt",sep="\t")
