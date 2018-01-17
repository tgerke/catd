rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE26126_full_pdata.csv",as.is=TRUE,row.names=1)

#Note: Due to problem curating "3+5", see gleason grade code below.
#In summary, the gleasongrade code is the sum of the 2 measurements, although we 
#have the individual measurements in the uncurated (not in the curated at the moment)
##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

#sample_type
tmp <- uncurated$characteristics_ch1.2
tmp[tmp=="disease state: Tumor"] <- "tumor"
tmp[tmp=="disease state: Normal"] <- "adjacentnormal"
curated$sample_type <- tmp

#age_at_initial_pathologic_diagnosis
tmp <- uncurated$characteristics_ch1.3
tmp <- sub("age:", "", tmp, fixed = TRUE)
curated$age_at_initial_pathologic_diagnosis <- tmp

#psa_at_diagnosis
tmp <- uncurated$characteristics_ch1.4
tmp <- sub("pre-treatment psa: ", "", tmp, fixed = TRUE)
curated$psa_at_diagnosis <- tmp

#gleasongrade
tmp <- uncurated$characteristics_ch1.5
tmp <- sub("path gr (gleason): ", "", tmp, fixed = TRUE)
tmp[tmp=="3+3"] <- "6"
tmp[tmp=="3+4"] <- "7"
tmp[tmp=="3+5"] <- "8"
tmp[tmp=="4+3"] <- "7"
tmp[tmp=="4+4"] <- "8"
tmp[tmp=="4+5"] <- "9"
tmp[tmp==""] <- NA
curated$gleasongrade <- tmp

#summarygrade
tmp <- uncurated$characteristics_ch1.5
tmp <- sub("path gr (gleason): ", "", tmp, fixed = TRUE)
tmp[tmp=="3+3"] <- "low"
tmp[tmp=="3+4"] <- "intermediate"
tmp[tmp=="3+5"] <- "high"
tmp[tmp=="4+3"] <- "intermediate"
tmp[tmp=="4+4"] <- "high"
tmp[tmp=="4+5"] <- "high"
tmp[tmp==""] <- NA
curated$summarygrade <- tmp

#days_to_death
tmp <- uncurated$characteristics_ch1.6
tmp <- sub("months followed-up:", "", tmp, fixed = TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_death <- tmp

#recurrence_status
tmp <- uncurated$characteristics_ch1.7
tmp[tmp=="recurrence: None"] <- "norecurrence"
tmp[tmp=="recurrence: Biochemical"] <- "recurrence"
tmp[tmp==""] <- NA
tmp[tmp=="recurrence: Unknown"] <- NA
curated$recurrence_status <- tmp

#days_to_recurrence
tmp <- uncurated$characteristics_ch1.8
tmp <- sub("days to recurrence: ", "", tmp, fixed = TRUE)
curated$days_to_recurrence_or_death <- tmp

#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE26126_curated_pdata.txt",sep="\t")
