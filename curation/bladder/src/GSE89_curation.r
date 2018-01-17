rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE89_full_pdata.csv",as.is=TRUE,row.names=1)
#rfs <- read.csv("../uncurated/GSE89_rfs_from_ng1061-S12.csv",as.is=TRUE,row.names=1)

celfile.dir <- "../../../DATA/GSE89/RAW"

##initial creation of curated dataframe
curated <-
initialCuratedDF(rownames(uncurated),template.filename="template_bladder.csv")


##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- gsub("Bladder sample ","",uncurated$title)
tmp <- gsub("_","-",tmp)

curated$alt_sample_name <- tmp

##sample_type are all tumor
curated$sample_type <- "tumor"

##Pathological T: -> T
curated$T <-  as.numeric(gsub("a", 0, substr(uncurated$description,2,2)))

##Pathological T: -> summarystage
tmp <- ifelse(curated$T < 2, "superficial", "invasive")
curated$summarystage <- tmp

curated$G[ grep("gr2", uncurated$description) ] = 2
curated$G[ grep("gr3|gr 3", uncurated$description) ] = 3
curated$G[ grep("gr4", uncurated$description) ] = 4


curated <- postProcess(curated, uncurated, do.celfile.batch=FALSE)

write.table(curated, row.names = FALSE, file="../curated/GSE89_curated_pdata.txt",sep="\t")
