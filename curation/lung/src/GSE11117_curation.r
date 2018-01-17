rm(list=ls())
source("../../functions.R")
getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE11117_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE11117/RAW"

##initial creation of curated dataframe

curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#histology
#gender (who is 0? who is 1?)
#age
#days_to_death
#stage (again, T NOT = to stage.  How should I do this?)
#substage
#N
#M

#alt_sample_name
curated$alt_sample_name <- uncurated$title

#histology
tmp <- uncurated$characteristics_ch1
tmp[tmp=="Phenotype: NSCLC-squa."] <- "nsclc_squa"
tmp[tmp=="Phenotype: Ctr.-Infl."] <- "ctr_infl"
tmp[tmp=="Phenotype: NSCLC-NOS"] <- "nsclc_nos"
tmp[tmp=="Phenotype: NSCLC-Adeno"] <- "nsclc_adeno"
curated$histology <- tmp

#age_at_initial_pathologic_diagnosis
tmp <- uncurated$characteristics_ch1.2
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
curated$age_at_initial_pathologic_diagnosis <- tmp

#days_to_death
tmp <- uncurated$characteristics_ch1.4
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp[tmp==""] <- NA
curated$days_to_death <- tmp

#vital_status
tmp <- uncurated$characteristics_ch1.3
tmp[tmp=="status: 0"] <- "living"
tmp[tmp=="status: 1"] <- "deceased"
tmp[tmp=="status: NA"] <- NA
curated$vital_status <- tmp

#N
tmp <- uncurated$characteristics_ch1.7
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp[tmp==""] <- NA
curated$N <- tmp

#M
tmp <- uncurated$characteristics_ch1.8
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp[tmp==""] <- NA
curated$M <- tmp

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE11117_curated_pdata.txt",sep="\t")
