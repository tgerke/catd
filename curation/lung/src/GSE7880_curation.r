rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE7880_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE7880/RAW"

##initial creation of curated dataframe

curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#age
#gender
#histology
#recurrence_status
#received_platinum_based_therapy_with_progression

#alt_sample_name
curated$alt_sample_name <- uncurated$title

#histology
tmp <- uncurated$characteristics_ch1.2
tmp[tmp=="disease: Adenocarcinoma"] <- "ad"
tmp[tmp=="disease: adenocarcinoma"] <- "ad"
tmp[tmp=="disease: recurrent AC"] <- "ad"
tmp[tmp=="disease: recurrent NSCLC"] <- NA
tmp[tmp=="disease: SCC"] <- "sq"
tmp[tmp=="disease: recurrent SCC"] <- "sq"
tmp[tmp=="disaese: recurrent SCC"] <- "sq"
curated$histology <- tmp

#age_at_initial_pathologic_diagnosis
tmp <- uncurated$characteristics_ch1
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
curated$age_at_initial_pathologic_diagnosis <- tmp

#gender
tmp <- uncurated$characteristics_ch1.1
tmp[tmp=="gender: m"] <- "m"
tmp[tmp=="gender:m"] <- "m"
tmp[tmp=="gender: w"] <- "f"
curated$gender <- tmp

#recurrence_status
tmp <- uncurated$characteristics_ch1.2
tmp[tmp=="disease: Adenocarcinoma"] <- "norecurrence"
tmp[tmp=="disease: adenocarcinoma"] <- "norecurrence"
tmp[tmp=="disease: recurrent AC"] <- "recurrence"
tmp[tmp=="disease: recurrent NSCLC"] <- "recurrence"
tmp[tmp=="disease: SCC"] <- "norecurrence"
tmp[tmp=="disease: recurrent SCC"] <- "recurrence"
tmp[tmp=="disaese: recurrent SCC"] <- "recurrence"
curated$recurrence_status <- tmp

#received_platinum therapy
tmp <- uncurated$characteristics_ch1.3
tmp[tmp=="received platinum-based therapy with progression: no "] <- "n"
tmp[tmp=="received platinum-based therapy with progression: yes "] <- "y"
curated$received_platinum_based_therapy_with_progression <- tmp

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE7880_curated_pdata.txt",sep="\t")
