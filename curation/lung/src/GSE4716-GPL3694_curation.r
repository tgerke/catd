rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE4716-GPL3694_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE4716-GPL3694/RAW"

##initial creation of curated dataframe

curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#sample_type
#primarysite
#days_to_death
#vital_status
#histology
#age_at_initial_pathologic_diagnosis
#gender
#T
#substage
#N

##title -> alt_sample_name
tmp <- uncurated$characteristics_ch1
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
curated$alt_sample_name <- tmp

#sample_type
curated$sample_type <- "tumor"

#primarysite
curated$primarysite <- "lung"

#days_to_death
tmp <- uncurated$characteristics_ch1.1
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
#multiply months * 30days/month = days
tmp <- as.numeric(tmp)
tmp <- tmp * 30
curated$days_to_death <- tmp

#vital_status
tmp <- uncurated$characteristics_ch1.2
tmp[tmp=="status after 5 years: Alive"] <- "living"
tmp[tmp=="status after 5 years: Dead"] <- "deceased"
curated$vital_status <- tmp

#histology
tmp <- uncurated$characteristics_ch1.3
tmp[tmp=="HIST: SQ"] <- "sq"
tmp[tmp=="HIST: LA"] <- "la"
tmp[tmp=="HIST: AD"] <- "ad"
curated$histology <- tmp

#Stage
tmp <- uncurated$characteristics_ch1.6
tmp[tmp=="pStage: IIB"] <- "2"
tmp[tmp=="pStage: IIIA"] <- "3"
tmp[tmp=="pStage: IB"] <- "1"
tmp[tmp=="pStage: IA"] <- "1"
tmp[tmp=="pStage: IIA"] <- "2"
tmp[tmp=="pStage: IIIB"] <- "3"
curated$pstage <- tmp

#substage
tmp <- uncurated$characteristics_ch1.6
tmp[tmp=="pStage: IIB"] <- "b"
tmp[tmp=="pStage: IIIA"] <- "a"
tmp[tmp=="pStage: IB"] <- "b"
tmp[tmp=="pStage: IA"] <- "a"
tmp[tmp=="pStage: IIA"] <- "a"
tmp[tmp=="pStage: IIIB"] <- "b"
curated$substage <- tmp

#N
tmp <- uncurated$characteristics_ch1.8
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
curated$N <- tmp

#T
tmp <- uncurated$characteristics_ch1.7
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
curated$T <- tmp


curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE4716-GPL3694_curated_pdata.txt",sep="\t")
