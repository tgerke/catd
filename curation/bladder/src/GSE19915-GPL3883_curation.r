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

uncurated <- read.csv("../uncurated/GSE19915-GPL3883_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE19915-GPL3883/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_bladder.csv")

##--------------------
##start the mappings
##--------------------

##alt_sample_name
curated$alt_sample_name <- uncurated$title

##sample_type are all tumor
curated$sample_type <- ifelse(getVal(uncurated,"sample histology: ") ==
"Normal bladder", "healthy", "tumor")


##Pathological T: -> T
curated$T <- as.numeric(gsub("a", 0, substr(getVal(uncurated,
    "tumor stage: "),2,2)))

##Pathological T: -> summarystage
tmp <- ifelse(curated$T < 2, "superficial", "invasive")
curated$summarystage <- tmp

curated$G <- as.numeric(gsub("a", 0, substr(getVal(uncurated,
    "tumor grade: "),2,2)))

tmp <- getVal(uncurated, "dead of disease: ")

tmp[tmp=="YES"] <- "deceased"
tmp[tmp=="NO"] <- "living"
curated$vital_status <- tmp

curated$days_to_death            =  
round(as.numeric(getVal(uncurated, "follow up time (months): "))*(365.25/12))

curated <- postProcess(curated, uncurated)

write.table(curated, row.names=FALSE, file="../curated/GSE19915-GPL3883_curated_pdata.txt",sep="\t")



