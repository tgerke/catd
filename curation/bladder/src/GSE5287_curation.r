rm(list=ls())
source("../../functions.R")
getCol <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

getVal <-function(uncurated,string) {
    gsub(string, "", apply(uncurated,1,getCol,string=string), fixed=TRUE)
}

uncurated <- read.csv("../uncurated/GSE5287_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE5287/RAW"

##initial creation of curated dataframe
curated <-
initialCuratedDF(rownames(uncurated),template.filename="template_bladder.csv")


##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

# all labeled as stage 2-4, so use the highest
curated$T <- 4
curated$summarystage <- "invasive"

curated$sample_type <- "tumor"

curated$days_to_death = as.numeric(getVal(uncurated,string="Survival (months): "))*30
curated$vital_status = ifelse(curated$days_to_death> 7000, "living", "deceased")

curated$neoadjuvant_chemo <- "n"
curated$adjuvant_chemo <- "y"

curated$adjuvant_regimen = "cisplatin"

curated <- postProcess(curated, uncurated)

write.table(curated, row.names = FALSE, file="../curated/GSE5287_curated_pdata.txt",sep="\t")
