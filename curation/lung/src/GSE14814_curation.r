rm(list=ls())
source("../../functions.R")
getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE14814_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE14814/RAW"

##initial creation of curated dataframe

curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#primarysite
#stage (same as T?)
#age
#gender
#cause_of_death
#vital_status
#histology
#days_to_death

curated$alt_sample_name <- uncurated$title

curated$primarysite <- "lung"

#T
tmp <- uncurated$characteristics_ch1.1
tmp <- gsub("Stage: ","",tmp,perl=TRUE)
tmp[tmp=="I"] <- "1"
tmp[tmp=="II"] <- "2"
curated$T <- tmp

#age_at_initial_pathologic_diagnosis
tmp <- uncurated$characteristics_ch1.2
tmp <- gsub("age: ","",tmp,perl=TRUE)
curated$age_at_initial_pathologic_diagnosis <- tmp

#gender
tmp <- uncurated$characteristics_ch1.3
tmp[tmp=="Sex: Male"] <- "m"
tmp[tmp=="Sex: Female"] <- "f"
curated$gender <- tmp

#cause_of_death
tmp <- uncurated$characteristics_ch1.4
tmp[tmp=="Cause of death: Alive"] <- "alive"
tmp[tmp=="Cause of death: Lung cancer"] <- "lungcancer"
tmp[tmp=="Cause of death: Other conditions"] <- "other_conditions"
curated$cause_of_death <- tmp

#histology
tmp <- uncurated$characteristics_ch1.5
tmp[tmp=="Histology type: ADC"] <- "ad"
tmp[tmp=="Histology type: SQCC"] <- "sq"
tmp[tmp=="Histology type: LCUC"] <- "lcuc"
curated$histology <- tmp

#vital_status
tmp <- uncurated$characteristics_ch1.7
tmp[tmp=="OS status: Alive"] <- "living"
tmp[tmp=="OS status: Dead"] <- "deceased"
curated$vital_status <- tmp

#days_to_death
tmp <- uncurated$characteristics_ch1.6
tmp <- gsub("OS time: ","",tmp,perl=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 365
curated$days_to_death <- tmp

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE14814_curated_pdata.txt",sep="\t")
