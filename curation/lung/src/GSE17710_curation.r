rm(list=ls())
source("../../functions.R")
getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE17710_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE17710/RAW"

##initial creation of curated dataframe

curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------


curated$alt_sample_name <- uncurated$title

curated$primarysite <- "lung"

curated$sample_type <- "tumor"

curated$histology <- "sq"

#subtype
tmp <- uncurated$characteristics_ch1
tmp <- gsub("subtype: ","",tmp,perl=TRUE)
curated$subtype <- tmp

#age
tmp <- uncurated$characteristics_ch1.1
tmp <- gsub("age: ","",tmp,perl=TRUE)
curated$age_at_initial_pathologic_diagnosis <- tmp

#gender
tmp <- uncurated$characteristics_ch1.2
tmp[tmp=="sex: Female"] <- "f"
tmp[tmp=="sex: Male"] <- "m"
curated$gender <- tmp

#smoker
tmp <- uncurated$characteristics_ch1.3
tmp[tmp=="smoking_status(0=nonsmoker,1=smoker): 1"] <- "y"
tmp[tmp=="smoking_status(0=nonsmoker,1=smoker): 0"] <- "n"
curated$smoker <- tmp

#packyears
tmp <- uncurated$characteristics_ch1.4
tmp <- apply(uncurated,1,getVal,string="pack_years: ")
tmp <- sub("pack_years: ","",tmp,fixed=TRUE)
curated$packyears <- tmp

#summarygrade
tmp <- apply(uncurated,1,getVal,string="grade:")
tmp[tmp=="grade: mod"] <- "moderately"
tmp[tmp=="grade: poor"] <- "poorly"
curated$summarygrade <- tmp

#days_to_death
tmp <- apply(uncurated,1,getVal,string="survival_months:")
tmp <- sub("survival_months:","",tmp,fixed=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp* 30
curated$days_to_death <- tmp

#vital_status
tmp <- apply(uncurated,1,getVal,string="survival_status(0='alive',1='dead'):")
tmp[tmp=="survival_status(0='alive',1='dead'): 1"] <- "deceased"
tmp[tmp=="survival_status(0='alive',1='dead'): 0"] <- "living"
curated$vital_status <- tmp
 
#recurrence_status
tmp <- apply(uncurated,1,getVal,string="relapse_status")
tmp[tmp=="relapse_status(0='no relapse',1='relapse'): 1"] <- "recurrence"
tmp[tmp=="relapse_status(0='no relapse',1='relapse'): 0"] <- "norecurrence"
curated$recurrence_status <- tmp

#days_to_tumor_recurrence
tmp <- apply(uncurated,1,getVal,string="relapse_free_months:")
tmp <- sub("relapse_free_months:","",tmp,fixed=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp* 30
curated$days_to_tumor_recurrence <- tmp

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE17710_curated_pdata.txt",sep="\t")
