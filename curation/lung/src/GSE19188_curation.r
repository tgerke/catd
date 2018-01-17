rm(list=ls())
source("../../functions.R")
getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE19188_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE19188/RAW"

##initial creation of curated dataframe

curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------


curated$alt_sample_name <- uncurated$title

#sample_type
tmp <- uncurated$characteristics_ch1
tmp[tmp=="tissue type: tumor"] <- "tumor"
tmp[tmp=="tissue type: healthy"] <- "healthy"
curated$sample_type <- tmp

#histology
tmp <- uncurated$characteristics_ch1.1
tmp[tmp=="cell type: LCC"] <- "lcc"
tmp[tmp=="cell type: healthy"] <- "normal"
tmp[tmp=="cell type: ADC"] <- "ad"
tmp[tmp=="cell type: SCC"] <- "scc"
curated$histology <- tmp

#days_to_death
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("overall survival: ","",tmp,fixed=TRUE)
tmp[tmp=="Not available"] <- NA
tmp <- as.numeric(tmp)
tmp <- tmp * 30
curated$days_to_death <- tmp

#vital_status
tmp <- uncurated$characteristics_ch1.3
tmp[tmp=="status: deceased"] <- "deceased"
tmp[tmp=="status: alive"] <- "living"
tmp[tmp=="status: Not available"] <- NA
curated$vital_status <- tmp

#gender
tmp <- uncurated$characteristics_ch1.4
tmp[tmp=="gender: M"] <- "m"
tmp[tmp=="gender: F"] <- "f"
tmp[tmp=="gender: Not available"] <- NA
curated$gender <- tmp

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE19188_curated_pdata.txt",sep="\t")
