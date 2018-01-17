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

uncurated <- read.csv("../uncurated/GSE30009_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE30009/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

curated$alt_sample_name <- uncurated$title

curated$sample_type="tumor"

curated$days_to_death <- round(as.numeric(getVal(uncurated, 
    "overall survival (os; months): ")  ) * 365.25/12)

curated$age_at_initial_pathologic_diagnosis <- as.numeric(getVal(uncurated,
"age: "))

tmp <- getVal(uncurated, "status: ")
curated$vital_status <- ifelse(grepl("dead",tmp), "deceased", "living")


tmp <- getVal(uncurated, "surgical debulking or residual disease (cm): ")
curated$debulking <- ifelse(tmp=="<1", "optimal", "suboptimal")

tmp <- getVal(uncurated, "histology: ")
curated$subtype <-  ifelse(tmp == "serous, endometrioid" , "clearcell", "ser")

curated$T <- as.numeric(substr(getVal(uncurated, "figo stage: "),1,1))
curated$summarystage <- ifelse(curated$T<3,"early", "late")
curated$substage <- gsub("^$",NA,tolower(substr(getVal(uncurated, "figo stage: "),2,2)))

curated$G <- as.numeric(getVal(uncurated, "tumor grade: "))
curated$summarygrade <- ifelse(curated$G < 3, "low", "high")


curated <- postProcess(curated)

write.table(curated, row.names=FALSE, file="../curated/GSE30009_curated_pdata.txt",sep="\t")



