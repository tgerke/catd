rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE23022_full_pdata.csv",as.is=TRUE,row.names=1)


##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type
tmp <- ifelse(uncurated$characteristics_ch1.1=="disease state: Primary prostate cancer","tumor","adjacentnormal")
curated$sample_type <- tmp

#overall_stage_pathological
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("tumor stage: pT", "", tmp, fixed = TRUE)
tmp[tmp==""] <- NA
curated$overall_stage_pathological <- tmp    

#gleasongrade
tmp <- uncurated$characteristics_ch1.3
tmp <- as.numeric(gsub("[^\\d]","",tmp,perl=TRUE))
curated$gleasongrade <- tmp

#summarygrade
tmp <- curated$gleasongrade
tmp[tmp=="7"] <- "intermediate"
tmp[tmp=="9"] <- "high"
curated$summarygrade <- tmp

#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE23022_curated_pdata.txt",sep="\t")
