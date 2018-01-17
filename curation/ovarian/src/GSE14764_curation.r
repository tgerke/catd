rm(list=ls())

source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE14764_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE14764/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")
##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
tmp <- sub("ovarian cancer: O","",tmp,fixed=TRUE)
curated$alt_sample_name <- tmp

##characteristics_ch1.3 -> subtype
tmp <- uncurated$characteristics_ch1.3
tmp[tmp=="histological type: serous ovca"] <- "ser"
tmp[tmp=="histological type: endometr ovca"] <- "endo"
tmp[tmp=="histological type: clear cell ovca"] <- "clearcell"
tmp[tmp=="histological type: undifferentiated ovca"] <- "undifferentiated"
tmp[tmp=="histological type: clear cell ovca"] <- "clearcell"
tmp[tmp=="histological type: transitional cell ca"] <- "other"
tmp[tmp=="histological type: endometr, clear cell ovca"] <- "mix"
tmp[tmp=="histological type: sarcomatoid"] <- "other"
curated$subtype <- tmp

#primary site all "ov"?
curated$primarysite <- "ov"

#debulking all unknown
curated$debulking <- NA #was "unknown"

##sample_type are all "tumor"
curated$sample_type <- "tumor"

##characteristics_ch1.1 -> T
tmp <- uncurated$characteristics_ch1.1
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
curated$T <- tmp

##summarystage
tmp <- uncurated$characteristics_ch1.1
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp[tmp==""] <- NA
tmp[tmp=="1"] <-"early"
tmp[tmp=="2"] <-"early"
tmp[tmp=="3"] <-"late"
tmp[tmp=="4"] <-"late"
curated$summarystage <- tmp

##characteristics_ch1.1 -> substage
tmp <- uncurated$characteristics_ch1.1
tmp <- sub("figo stage: ","",tmp,fixed=TRUE)
tmp <- gsub("[^abc]","",tmp)
tmp[tmp==""] <- NA
curated$substage <- tmp

##characteristics_ch1.2 -> G
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("grade: ","",tmp,fixed=TRUE)
tmp[tmp=="I"] <- "1"
tmp[tmp=="II"] <- "2"
tmp[tmp=="III"] <- "3"
curated$G <- tmp

##summarygrade
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("grade: ","",tmp,fixed=TRUE)
tmp[tmp=="I"] <-"low"
tmp[tmp=="II"] <-"low"
tmp[tmp=="III"] <-"high"
curated$summarygrade <- tmp

##characteristics_ch1.5 -> days_to_death
tmp <- uncurated$characteristics_ch1.5
#tmp <- sub("overall survival time: ","",tmp,fixed=TRUE)
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_death <- tmp

##characteristics_ch1.4-> recurrence_status
tmp <- uncurated$characteristics_ch1.4
tmp <- sub("residual tumor: ","",tmp,fixed=TRUE)
tmp[tmp=="0"] <- "norecurrence"
tmp[tmp=="1"] <- "recurrence"
curated$recurrence_status <- tmp

##characteristics_ch1.6-> vital_status
tmp <- uncurated$characteristics_ch1.6
tmp <- sub("overall survival event: ", "",tmp,fixed=TRUE) 
tmp[tmp=="0"] <- "living"
tmp[tmp=="1"] <- "deceased"
curated$vital_status <- tmp
 
#tmp2 <- edit(curated) 

curated <- postProcess(curated)

write.table(curated, row.names=FALSE, file="../curated/GSE14764_curated_pdata.txt",sep="\t")
