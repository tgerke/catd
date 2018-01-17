rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE21034-GPL10264_full_pdata.csv",as.is=TRUE,row.names=1)


##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type
tmp <- uncurated$characteristics_ch1.3
tmp[tmp=="tumor type: Primary tumor"] <- "tumor"
tmp[tmp=="tumor type: Metastasis"] <- "metastatic"
tmp[tmp==""] <- NA
curated$sample_type <- tmp

#gleasongrade
tmp <- uncurated$characteristics_ch1.4
tmp <- as.numeric(gsub("[^\\d]","",tmp,perl=TRUE))
curated$gleasongrade <- tmp

#summarygrade
tmp <- curated$gleasongrade
tmp[tmp=="5"] <- "low"
tmp[tmp=="6"] <- "low"
tmp[tmp=="7"] <- "intermediate"
tmp[tmp=="8"] <- "high"
tmp[tmp=="9"] <- "high"
curated$summarygrade <- tmp

#overall_stage_clinical
tmp <- uncurated$characteristics_ch1.5
tmp <- tolower(sub("clint_stage: T", "", tmp, fixed = TRUE))
tmp[tmp=="clint_stage: na"] <- NA
tmp[tmp==""] <- NA
curated$overall_stage_clinical <- tmp    

#overall_stage_pathological
tmp <- uncurated$characteristics_ch1.6
tmp <- tolower(sub("pathological_stage: T", "", tmp, fixed = TRUE))
tmp[tmp=="pathological_stage: na"] <- NA
tmp[tmp==""] <- NA
curated$overall_stage_pathological <- tmp    

#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE21034-GPL10264_curated_pdata.txt",sep="\t")
