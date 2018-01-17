rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE7949_full_pdata.csv",as.is=TRUE,row.names=1)

##Note: Same isssue w/ the "+" in Gleason Grade.  Just the sum of the two measurements
#is scripted, but the uncurated has the break down of each measurement...
##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type
curated$sample_type <-"tumor"

#age
#note: how can i make this get called by the function I wrote for age in function.R?
#dif. is that that function is "Age: x", and this one goes "Age:x"\
tmp <- uncurated$characteristics_ch1.5
tmp <- sub("Age:","",tmp,fixed=TRUE)
curated$age_at_initial_pathologic_diagnosis <- tmp

#psa_at_diagnosis
tmp <- uncurated$characteristics_ch1.6
tmp <- sub("PSA: ","",tmp,fixed=TRUE)
curated$psa_at_diagnosis <- tmp

#androgen_ablation
tmp <- uncurated$characteristics_ch1.7
tmp <- sub("Androgen Ablation: ","",tmp,fixed=TRUE)
tmp[tmp=="yes"] <- "y"
tmp[tmp=="no"] <- "n"
curated$androgen_ablation. <- tmp

##gleasongrade
#Q: here it is called "Gleason Score", it is "Gleason Grade" in my functions.R function.  Can I merge them?
tmp <- uncurated$characteristics_ch1.8
tmp[tmp=="Gleason Score: 4 (3+1)"] <- "4"
tmp[tmp=="Gleason Score: 5 (3+2)"] <- "5"
tmp[tmp=="Gleason Score: 6 (3+3)"] <- "6"
tmp[tmp=="Gleason Score: 7 (3+4)"] <- "7"
tmp[tmp=="Gleason Score: 7 (4+3)"] <- "7"
tmp[tmp=="Gleason Score: 7 (5+2)"] <- "7"
tmp[tmp=="Gleason Score: 8 (3+5)"] <- "8"
tmp[tmp=="Gleason Score: 8 (4+4)"] <- "8"
curated$gleasongrade <- tmp

#summarygrade
tmp <- curated$gleasongrade
tmp[tmp=="4"] <- "low"
tmp[tmp=="5"] <- "low"
tmp[tmp=="6"] <- "low"
tmp[tmp=="7"] <- "intermediate"
tmp[tmp=="3+4"] <- "intermediate"
tmp[tmp=="4+3"] <- "intermediate"
tmp[tmp=="8"] <- "high"
curated$summarygrade <- tmp

#overall_stage_pathological
tmp <- uncurated$characteristics_ch1.9
tmp <- sub("Pathology Stage: T","",tmp,fixed=TRUE)
curated$overall_stage_pathological <- tmp

#is there a way to better generalize substage?
tmp <- uncurated$characteristics_ch1.9
tmp <- sub("Pathology Stage: T","",tmp,fixed=TRUE)
tmp <- gsub("[^\\D]","",tmp,perl=TRUE)
curated$substage <- tmp

#capsule
tmp <- uncurated$characteristics_ch1.10
tmp <- sub("Capsule: ","",tmp,fixed=TRUE)
tmp <- tolower(tmp)
curated$capsule. <- tmp

##days_to_tumor_recurrence
tmp <- uncurated$characteristics_ch1.11
tmp <- sub("Months to recurrence:","",tmp,fixed=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_tumor_recurrence <- tmp

##days_to_recurrence_or_death
tmp <- uncurated$characteristics_ch1.12
tmp <- sub("Months of follow up: ","",tmp,fixed=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_recurrence_or_death <- tmp


#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE7949_curated_pdata.txt",sep="\t")
