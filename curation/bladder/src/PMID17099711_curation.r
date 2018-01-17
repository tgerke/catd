rm(list=ls())
source("../../functions.R")
getCol <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

getVal <-function(uncurated,string) {
    gsub(string, "", apply(uncurated,1,getCol,string=string))
}

uncurated <- read.delim("../uncurated/PMID17099711_full_pdata.txt",as.is=TRUE, row.names=27)
rownames(uncurated) = gsub(".CEL", "", rownames(uncurated))

celfile.dir <- "../../../DATA/PMID17099711/RAW"

##initial creation of curated dataframe
curated <-
initialCuratedDF(rownames(uncurated),template.filename="template_bladder.csv")


##--------------------
##start the mappings
##--------------------

curated$unique_patient_ID <- make.names(uncurated$Source.Name)

curated$sample_type <- ifelse(uncurated$Factor.Value..DiseaseState.=="normal",
"healthy", "tumor")

curated$T =  as.numeric(gsub("a", 0, substr(uncurated$Factor.Value..DiseaseStaging.,10,10)))

tmp = substr(uncurated$Factor.Value..DiseaseStaging.,11,11)
tmp[tmp==""] = NA
curated$substage = tmp

curated$summarystage = ifelse(curated$T < 2, "superficial", "invasive")

curated$N = as.numeric(substr(uncurated$Factor.Value..DiseaseStaging.,2,2))

tmp =  substr(uncurated$Factor.Value..DiseaseStaging.,6,6)
tmp[ tmp =="x" ] = NA
curated$M = tmp

curated$G = as.numeric(sapply(uncurated$Factor.Value..TumorGrading., function(x) substr(x, nchar(x), nchar(x))))

curated$gender = substr(uncurated$Factor.Value..Sex.,1,1)

curated <- postProcess(curated, uncurated)

idx = grep("av2$",rownames(curated))

write.table(curated[idx,], row.names = FALSE,
    file="../curated/PMID17099711-GPL8300_curated_pdata.txt",sep="\t")

write.table(curated[-idx,], row.names = FALSE,
    file="../curated/PMID17099711-GPL91_curated_pdata.txt",sep="\t")

