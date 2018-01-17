rm(list=ls())
source("../../functions.R")
getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE8894_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE8894/RAW"

##initial creation of curated dataframe

curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#sample_type
#primarysite
#recurrence_status
#age
#gender
#histology
#days_to_tumor_recurrence

#alt_sample_name
tmp <- uncurated$title
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
curated$alt_sample_name <- tmp

#sample_type
curated$sample_type <- "tumor"

#primarysite
curated$primarysite <- lung

#recurrence_status
tmp <- apply(uncurated,1,getVal,string="status(1=recurrence, 0=non-recurrence):")
tmp[tmp=="status(1=recurrence, 0=non-recurrence): 0"] <- "norecurrence"
tmp[tmp=="status(1=recurrence, 0=non-recurrence): 1"] <- "recurrence"
curated$recurrence_status <- tmp

#age_at_initial_pathologic_diagnosis
tmp <- apply(uncurated,1,getVal,string="age:")
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
curated$age_at_initial_pathologic_diagnosis <- tmp

#gender
tmp <- apply(uncurated,1,getVal,string="gender:")
tmp[tmp=="gender: Female"] <- "f"
tmp[tmp=="gender: Male"] <- "m"
curated$gender <- tmp

#histology
tmp <- apply(uncurated,1,getVal,string="cell type:")
tmp[tmp=="cell type: Adenocarcinoma"] <- "ad"
tmp[tmp=="cell type: Squarmus cell carcinoma"] <- "sq"
tmp[tmp=="cell type: Squarmus celll carcinoma"] <- "sq"
curated$histology <- tmp

#days_to_tumor_recurrence
tmp <- apply(uncurated,1,getVal,string="recurrence free survival time (month):")
tmp <- sub("recurrence free survival time (month):","",tmp,fixed=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 30
curated$days_to_tumor_recurrence <- tmp

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE8894_curated_pdata.txt",sep="\t")
