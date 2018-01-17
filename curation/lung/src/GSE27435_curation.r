rm(list=ls())
source("../../functions.R")
getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE27435_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE27435/RAW"

##initial creation of curated dataframe

curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------


curated$alt_sample_name <- uncurated$title

curated$histology <- "sclc"

curated$primarysite <- "lung"

#gender
tmp <- uncurated$characteristics_ch1.2
tmp[tmp=="gender: Male"] <- "m"
tmp[tmp=="gender: Female"] <- "f"
curated$gender <- tmp

#age
tmp <- uncurated$characteristics_ch1.3
tmp <- sub("age:","",tmp,fixed=TRUE)
curated$age_at_initial_pathologic_diagnosis <- tmp

#vital_status
tmp <- uncurated$characteristics_ch1.4
tmp[tmp=="status after follow-up: Dead"] <- "deceased"
tmp[tmp=="status after follow-up: Alive"] <- "living"
curated$vital_status <- tmp

#days_to_death
tmp <- uncurated$characteristics_ch1.5
tmp <- sub("overall survival (months): ","",tmp,fixed=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 30
curated$days_to_death <- tmp

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE27435_curated_pdata.txt",sep="\t")
