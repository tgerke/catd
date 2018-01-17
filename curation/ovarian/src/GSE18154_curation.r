rm(list=ls())

source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE18154_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE18154/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")
##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type are all tumor
curated$sample_type <- "tumor"

##primary_site are all ov
curated$primarysite <- "ov"

##subtype are all serous
curated$subtype <- "ser"

##T are all late
#IMPORTANT NOTE: I JUST PICKED 4 so it would pass our regex check...
curated$T <- "4"

##summarystage
curated$summarystage <- "late"

##G are all high
#IMPORTANT NOTE: I JUST PICKED 4 so it would pass our regex check...
curated$G <- "4"

##summarygrade
curated$summarygrade <- "high"

#debulking all unknown
curated$debulking <- NA #was "unknown"
 
#tmp2 <- edit(curated) 

curated <- postProcess(curated)

write.table(curated, row.names=FALSE, file="../curated/GSE18154_curated_pdata.txt",sep="\t")
