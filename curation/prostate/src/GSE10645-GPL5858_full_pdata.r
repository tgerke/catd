rm(list=ls())
source("../../functions.R")

uncurated1 <- read.csv("../uncurated/GSE10645-GPL5858_series_matrix-1.txt.gz_full_pdata.csv",as.is=TRUE,row.names=1)
uncurated2 <- read.csv("../uncurated/GSE10645-GPL5858_series_matrix-2.txt.gz_full_pdata.csv",as.is=TRUE,row.names=1)
uncurated3 <- read.csv("../uncurated/GSE10645-GPL5858_series_matrix-3.txt.gz_full_pdata.csv",as.is=TRUE,row.names=1)
uncurated <- rbind(uncurated1, uncurated2, uncurated3)

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

##age_at_initial_pathologic_diagnosis
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("Age (yrs) at RRP: ","",tmp,fixed=TRUE)
curated$age_at_initial_pathologic_diagnosis <- tmp

##psa_at_diagnosis
tmp <- uncurated$characteristics_ch1.3
tmp <- sub("PSA (ng/ml) at RRP: ","",tmp,fixed=TRUE)
curated$psa_at_diagnosis<- tmp

##gleasongrade
tmp <- uncurated$characteristics_ch1.4
tmp <- sub("Revised Gleason Score: ","",tmp,fixed=TRUE)
curated$gleasongrade <- tmp

##summarygrade
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
curated$summarygrade <- tmp 

#vital_status
tmp <- tolower(uncurated$characteristics_ch1.14)
tmp <- sub("patient's status: ","",tmp,fixed=TRUE)
tmp[tmp=="alive"] <- "living"
curated$vital_status <- tmp

#cancer_specific_death
tmp <- uncurated$characteristics_ch1.15
tmp <- sub("Prostate cancer specific death: ","",tmp,fixed=TRUE)
tmp[tmp=="Yes"] <- "y"
tmp[tmp=="No"] <- "n"
curated$cancer_specific_death <- tmp

#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE10645-GPL5858_curated_pdata.txt",sep="\t")
