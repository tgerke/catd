rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE6919-GPL8300_full_pdata.csv",as.is=TRUE,row.names=1)


##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type
tmp <- uncurated$characteristics_ch1
tmp <- sub(".+(metastases).+","\\1",tmp)
tmp[tmp=="metastases"] <- "metastatic"
tmp[tmp=="Tissue:normal prostate tissue free of any pathological alteration from brain-dead organ donor"] <- "healthy"
tmp[tmp=="Tissue:normal prostate tissue adjacent to tumor"] <- "adjacentnormal"
tmp[tmp=="Tissue:primary prostate tumor"] <- "tumor"
tmp[tmp=="Tissue: primary prostate tumor"] <- "tumor"
curated$sample_type <-tmp

##age
tmp <- sub(".+(Tumor stage).+","\\1",uncurated$characteristics_ch1.1)
tmp <- sub("Tumor stage",NA,tmp,fixed=TRUE)
tmp <- sub("Age: ","",tmp,fixed=TRUE)
#tmp <- sub("Age: ", "", tmp, fixed = TRUE)
curated$age_at_initial_pathologic_diagnosis <- tmp

##stage-- overall_stage_pathological values
tmp <- uncurated$characteristics_ch1.1
tmp <- sub(".+(Age: ).+","\\1",uncurated$characteristics_ch1.1)
tmp <- sub("Age: ",NA,tmp,fixed=TRUE)
tmp <- sub("Tumor stage: T","",tmp,fixed=TRUE)
tmp[tmp==""] <- NA
curated$overall_stage_pathological <- tmp

##substage-- pathological, I presume, because stage was overall_stage_pathological according to the values in our template
tmp <- uncurated$characteristics_ch1.1
tmp <- sub(".+(Age: ).+","\\1",uncurated$characteristics_ch1.1)
tmp <- sub("Age: ",NA,tmp,fixed=TRUE)
tmp <- sub("Tumor stage: T","",tmp,fixed=TRUE)
tmp <- gsub("[^\\D]","",tmp,perl=TRUE)
tmp[tmp==""] <- NA
curated$substage <- tmp

##race
tmp <- uncurated$characteristics_ch1.2
tmp <- sub(".+(Gleason Grade).+","\\1",uncurated$characteristics_ch1.2)
tmp <- sub("Gleason Grade",NA,tmp,fixed=TRUE)
tmp[tmp=="Race: Caucasian"] <- "caucasian"
tmp[tmp=="Race: African American"] <- "black"
tmp[tmp==""] <- NA
curated$race <- tmp

##gleasongrade
tmp <- uncurated$characteristics_ch1.2
tmp <- sub(".+(Race).+","\\1",uncurated$characteristics_ch1.2)
tmp <- sub("Race",NA,tmp,fixed=TRUE)
tmp <- sub("Gleason Grade: ","",tmp,fixed=TRUE)
curated$gleasongrade <- tmp

##summarygrade
#curated$summarygrade <- curate_summarygrade(uncurated$characteristics_ch1.2) 
tmp <- curated$gleasongrade
tmp[tmp=="2"] <- "low"
tmp[tmp=="3"] <- "low"
tmp[tmp=="4"] <- "low"
tmp[tmp=="5"] <- "low"
tmp[tmp=="6"] <- "low"
tmp[tmp=="7"] <- "intermediate"
tmp[tmp=="8"] <- "high"
tmp[tmp=="9"] <- "high"
tmp[tmp=="10"] <- "high" 
tmp[tmp==""] <- NA
curated$summarygrade <- tmp


#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE6919-GPL8300_curated_pdata.txt",sep="\t")
