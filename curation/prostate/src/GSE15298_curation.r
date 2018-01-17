rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE15298_full_pdata.csv",as.is=TRUE,row.names=1)


##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type
curated$sample_type <- "tumor"

#gleasongrade
tmp <- uncurated$source_name_ch1
tmp <- as.numeric(gsub("[^\\d]","",tmp,perl=TRUE))
curated$gleasongrade <- tmp

#summarygrade
tmp <- curated$gleasongrade
tmp[tmp=="6"] <- "low"
tmp[tmp=="8"] <- "high"
curated$summarygrade <- tmp

#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE15298_curated_pdata.txt",sep="\t")
