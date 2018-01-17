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

uncurated <- read.csv("../uncurated/GSE37317_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE37317/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_bladder.csv")

##--------------------
##start the mappings
##--------------------

##alt_sample_name
curated$alt_sample_name <- uncurated$title

##sample_type are all tumor
curated$sample_type <- "tumor"

curated$T <- as.numeric(gsub("a", 0, gsub("pT","", getVal(uncurated, "tumor stage: "))))

tmp <- ifelse(curated$T < 2, "superficial", "invasive")
curated$summarystage <- tmp

curated$histological_type <- ifelse(getVal(uncurated, "histology: ") ==
    "squamous cell carcinoma", "squamous", "tcc")

curated <- postProcess(curated, uncurated)

write.table(curated, row.names=FALSE, file="../curated/GSE37317_curated_pdata.txt",sep="\t")



