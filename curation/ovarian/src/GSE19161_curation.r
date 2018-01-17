rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE19161_full_pdata.csv",as.is=TRUE,row.names=1)

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

##--------------------
##start the mappings
##--------------------


##title -> alt_sample_name
tmp <- uncurated$title
tmp <- sub("Ovarian tumor sample ","",tmp,fixed=TRUE)
curated$alt_sample_name <- tmp

curated$primarysite <- "ov"

curated$sample_type <- "tumor"

curated$summarystage <- "late"

##characteristics_ch1.2-> days_to_death
tmp <- uncurated$characteristics_ch1
tmp <- sub("survival in months: ","",tmp,perl=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_death <- tmp

#vital_status
tmp <- uncurated$characteristics_ch1.1
tmp <- tmp <- sub("event indicator: ","",tmp,perl=TRUE)
tmp[tmp=="censored"] <- "living"
tmp[tmp=="event"] <- "deceased"
curated$vital_status <- tmp

  

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE19161_curated_pdata.txt",sep="\t")
