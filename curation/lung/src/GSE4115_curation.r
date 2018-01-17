rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE4115_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE4115/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#sample_type
#smoker
#primarysite
#age_at_initial_pathologic_diagnosis
#gender
#race
#packyears
#bronch_status

##title -> alt_sample_name
tmp <- uncurated$title
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
curated$alt_sample_name <- tmp

##sample_type 
tmp <- uncurated$characteristics_ch1
tmp[tmp=="Sample from smoker diagnosed with cancer"] <- "adjacentnormal"
tmp[tmp=="Sample from smoker NOT diagnosed with cancer"] <- "healthy"
tmp[tmp=="Sample from smoker with suspect lung cancer"] <- NA
curated$sample_type <- tmp

##smoker
curated$smoker <- "y"
  
##primarysite
curated$primarysite <- "bronch"

##age_at_initial_pathologic_diagnosis
tmp <- uncurated$characteristics_ch1.2
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp[tmp==""] <- NA
curated$age_at_initial_pathologic_diagnosis <- tmp

##gender
tmp <- uncurated$characteristics_ch1.3
tmp[tmp==""] <- NA
tmp[tmp=="gender: M"] <- "m"
tmp[tmp=="gender: F"] <- "f"
curated$gender <- tmp

##race
tmp <- uncurated$characteristics_ch1.4
tmp[tmp==""] <- NA
tmp[tmp=="race: OTHER"] <- "other"
tmp[tmp=="race: CAU"] <- "cau"
curated$race <- tmp

##packyears
tmp <- uncurated$characteristics_ch1.7
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp[tmp==""] <- NA
curated$packyears <- tmp

##bronch_status
tmp <- uncurated$characteristics_ch1.8
tmp[tmp==""] <- NA
tmp[tmp=="bronch_status: non-diagnostic"] <- "nondiagnostic"
tmp[tmp=="bronch_status: diagnostic"] <- "diagnostic"
curated$bronch_status <- tmp


curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE4115_curated_pdata.txt",sep="\t")
