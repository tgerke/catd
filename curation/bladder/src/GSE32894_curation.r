rm(list=ls())
source("../../functions.R")
library(gdata)
getCol <- function(x,string){
  output <- x[match(string,substr(x,1,nchar(string)))]
  if(length(output)==0) output <- NA
  return(output)
}

getVal <-function(uncurated,string) {
    gsub(string, "", apply(uncurated,1,getCol,string=string), fixed=TRUE)
}

uncurated <- read.csv("../uncurated/GSE32894_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE32894/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_bladder.csv")

##--------------------
##start the mappings
##--------------------

##alt_sample_name
curated$alt_sample_name <- uncurated$title

##sample_type are all tumor
curated$sample_type <- "tumor"


##Pathological T: -> T
curated$T <- as.numeric(gsub("a", 0, substr(getVal(uncurated, "tumor_stage: "),2,2)))
curated$G <- as.numeric(substr(getVal(uncurated, "tumor_grade: "),2,2))
curated$N <- as.numeric(substr(getVal(uncurated, "node_status: "),3,3))

##Pathological T: -> summarystage
tmp <- ifelse(curated$T < 2, "superficial", "invasive")
curated$summarystage <- tmp

##age_at_initial_pathologic_diagnosis
curated$age <- getVal(uncurated, "age: ")

curated$gender = tolower(substr(getVal(uncurated, "gender: "),1,1))

curated$days_to_death            =  round(
as.numeric(getVal(uncurated, "time_to_dod_(months): ")) *365.25/12)

curated$vital_status  = getVal(uncurated,  "dod_event_(yes/no): ") 
curated$vital_status  = gsub("no", "living", curated$vital_status) 
curated$vital_status  = gsub("yes", "deceased", curated$vital_status) 

curated$dfs_event = ifelse(getVal(uncurated,  "dod_event_(yes/no): ") ==
"yes", "dod", NA)

curated <- postProcess(curated, uncurated)

write.table(curated, row.names=FALSE, file="../curated/GSE32894_curated_pdata.txt",sep="\t")



