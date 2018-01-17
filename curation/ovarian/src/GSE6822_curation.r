rm(list=ls())

source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE6822_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE6822/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")
##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type all tumors
curated$sample_type <- "tumor"

##characteristics_ch1 -> subtype
tmp <- uncurated$characteristics_ch1
tmp[grep("serous",tmp,fixed=TRUE)] <- "ser" 
tmp[grep("undetermined",tmp,fixed=TRUE)] <- "undifferentiated" 
tmp[grep("endometrioid",tmp,fixed=TRUE)] <- "endo"
tmp[grep("clear cell",tmp,fixed=TRUE)] <- "clearcell"
tmp[grep("mixed",tmp,fixed=TRUE)] <- "mix"
tmp[grep("mucinous",tmp,fixed=TRUE)] <- "mucinous"
curated$subtype <- tmp

#primarysite all "ov"?
curated$primarysite <- "ov"

##characteristics_ch1 -> G
tmp <- uncurated$characteristics_ch1
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp[tmp=="23"] <- "3"
tmp[tmp=="2/3"] <- "3"
curated$G <- tmp

##summarygrade
tmp <- uncurated$characteristics_ch1
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp[tmp=="1"] <-"low"
tmp[tmp=="2"] <-"low"
tmp[tmp=="3"] <-"high"
tmp[tmp=="4"] <-"high"
tmp[tmp=="23"] <- "high"
tmp[tmp=="2/3"] <- "high"
tmp[tmp==""] <- NA
curated$summarygrade <- tmp

#debulking all unknown
curated$debulking <- NA #was "unknown"
 
curated <- postProcess(curated)

write.table(curated, row.names=FALSE, file="../curated/GSE6822_curated_pdata.txt",sep="\t")
