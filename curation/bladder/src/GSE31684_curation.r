rm(list=ls())
source("../../functions.R")
library(gdata)
getCol <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

getVal <-function(uncurated,string) {
    gsub(string, "", apply(uncurated,1,getCol,string=string), fixed=TRUE)
}

uncurated <- read.csv("../uncurated/GSE31684_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE31684/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_bladder.csv")

##--------------------
##start the mappings
##--------------------

##alt_sample_name
curated$alt_sample_name <- uncurated$title

##sample_type are all tumor
curated$sample_type <- "tumor"

curated$surgery_type <- "rc"

##subtype
tmp = tolower( getVal(uncurated, "rc_histology: ") )
 
tmp = gsub("tcc/","", tmp)
curated$histological_type <- tmp


##Pathological T: -> T
curated$T <- as.numeric(gsub("a", 0, substr(getVal(uncurated, "rc_stage: "),3,3)))

##Pathological T: -> summarystage
tmp <- ifelse(curated$T < 2, "superficial", "invasive")
curated$summarystage <- tmp

curated$summarygrade <- tolower(getVal(uncurated, "rc grade: " ))

 
##N 
tmp <- tolower(getVal(uncurated, "plnd result: " ))
tmp[tmp=="nx"] <- NA
tmp[tmp=="negative"] <- 0
tmp[tmp=="positive"] <- 1
curated$N <- as.numeric(tmp)

##M
tmp <- tolower(getVal(uncurated, "metastasis: " ))
curated$M <- ifelse(tmp==1, 1, 0)

##age_at_initial_pathologic_diagnosis
curated$age <- round(as.numeric(getVal(uncurated, "age at rc: ")))

curated$gender = tolower(substr(getVal(uncurated, "gender: "),1,1))

curated$days_to_tumor_recurrence =  round(
as.numeric(getVal(uncurated, 
"recurrence free survival months (distant and local): "))*365.25/12)
curated$days_to_death            =  round(
as.numeric(getVal(uncurated, "survival.months: ")) *365.25/12)
curated$vital_status  = ifelse(getVal(uncurated,  "last known status: ") != "NED", "deceased", "living")
curated$dfs_event = tolower(getVal(uncurated, "last known status: "))
curated$recurrence_status  = ifelse(getVal(uncurated, "recurrence/dod: ")=="Yes", "recurrence", "norecurrence")

curated$smoking_status = tolower(getVal(uncurated, "smoking: "))
curated$smoking_package_years = as.numeric(getVal(uncurated,
"smokingpack-years: "))
curated$nomogram_score = as.numeric(getVal(uncurated, "nomogram score: "))

curated$neoadjuvant_chemo = tolower(substr(getVal(uncurated, "prerc_chemo: "),1,1))
curated$adjuvant_chemo = ifelse(tolower(substr(getVal(uncurated, "post rc_chemo: "),1,1)) =="y","y", "n")

curated <- postProcess(curated, uncurated)

write.table(curated, row.names=FALSE, file="../curated/GSE31684_curated_pdata.txt",sep="\t")



