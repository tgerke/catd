rm(list=ls())
source("../../functions.R")
getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE10445_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE10445/RAW"

##initial creation of curated dataframe

curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#stage
#N
#age
#unclear what "STATE" means.  Recurrence? os_binary? check with Levi...


curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE10445_curated_pdata.txt",sep="\t")
