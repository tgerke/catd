rm(list=ls())
source("../../functions.R")
getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE27705_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE27705/RAW"

##initial creation of curated dataframe

curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------


curated$alt_sample_name <- uncurated$title

#histology
tmp <- uncurated$characteristics_ch1.1
tmp[tmp=="disease status: NSCLC patient"] <- "nsclc"
tmp[tmp=="disease status: normal control"] <- "normal"
curated$histology <- tmp

curated$primarysite <- "lung"

#age
tmp <- uncurated$characteristics_ch1.3
tmp <- sub("age:","",tmp,fixed=TRUE)
curated$age_at_initial_pathologic_diagnosis <- tmp

#vital_status
tmp <- uncurated$characteristics_ch1.4
tmp[tmp=="dead: 1"] <- "deceased"
tmp[tmp=="dead: 0"] <- "living"
curated$vital_status <- tmp

#summary_stage
tmp <- uncurated$source_name_ch1
tmp[tmp=="normal"] <- NA
curated$summary_stage <- tmp

#days_to_death
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("survival (months): ","",tmp,fixed=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 30
curated$days_to_death <- tmp

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE27705_curated_pdata.txt",sep="\t")
