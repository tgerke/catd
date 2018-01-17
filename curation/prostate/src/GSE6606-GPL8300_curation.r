rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE6606-GPL8300_full_pdata.csv",as.is=TRUE,row.names=1)


##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
tmp <- sub("Tumor samples from ","",tmp,fixed=TRUE)
curated$alt_sample_name <- tmp

##sample_type
curated$sample_type <- "tumor" 

##stage--overall_stage_pathological based on the values in the template
tmp <- uncurated$characteristics_ch1.1
tmp <- sub("Tumor stage: T","",tmp,fixed=TRUE) 
#tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
curated$overall_stage_pathological <- tmp

##substage
tmp <- curate_substage(uncurated$characteristics_ch1.1)
tmp[tmp==""] <- NA
curated$substage <- tmp
               
##gleasongrade
curated$gleasongrade <- curate_gleasongrade(uncurated$characteristics_ch1.2)

##summarygrade
#curated$summarygrade <- curate_summarygrade(uncurated$characteristics_ch1.2) 
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("Gleason Grade: ","",tmp,fixed=TRUE)
tmp[tmp=="2"] <- "low"
tmp[tmp=="3"] <- "low"
tmp[tmp=="4"] <- "low"
tmp[tmp=="5"] <- "low"
tmp[tmp=="6"] <- "low"
tmp[tmp=="7"] <- "intermediate"
tmp[tmp=="8"] <- "high"
tmp[tmp=="9"] <- "high"
tmp[tmp=="10"] <- "high" 
curated$summarygrade <- tmp


#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE6606-GPL8300_curated_pdata.txt",sep="\t")
