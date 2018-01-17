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

uncurated <- read.csv("../uncurated/GSE31189_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE31189/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_bladder.csv")

##--------------------
##start the mappings
##--------------------

##alt_sample_name
curated$alt_sample_name <- uncurated$title

##sample_type are all tumor
curated$sample_type <-  ifelse(getVal(uncurated, "disease status: ")==
    "bladder cancer", "tumor", "healthy")

curated <- postProcess(curated, uncurated)

write.table(curated, row.names=FALSE, file="../curated/GSE31189_curated_pdata.txt",sep="\t")



