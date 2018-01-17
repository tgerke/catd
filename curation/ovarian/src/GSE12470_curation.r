rm(list=ls())

source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE12470_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE12418/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##characteristics_ch1.1 -> sample_type
tmp <- uncurated$characteristics_ch1.1
tmp[tmp=="Tissue: normal peritoneum"] <- "healthy"
tmp[tmp=="Tissue: serous ovarian cancer"] <- "tumor"
tmp[tmp=="Tissue: ovarian cancer"] <- "tumor"
curated$sample_type <- tmp

##characteristics_ch1.1 -> subtype
tmp <- uncurated$characteristics_ch1.1
tmp[tmp=="Tissue: serous ovarian cancer"] <- "ser"
tmp[tmp=="Tissue: ovarian cancer"] <- "ser"
tmp[tmp=="Tissue: normal peritoneum"] <- NA
curated$subtype <- tmp

##primarysite are all ov?
curated$primarysite <- "ov"

##characteristics_ch1.2 -> T
tmp <- uncurated$characteristics_ch1.2
tmp[tmp=="Stage: advanced stage"] <- "4"
tmp[tmp=="Stage: early stage"] <- "2"
curated$T <- tmp

##characteristics_ch1.2 -> summarystage
tmp <- uncurated$characteristics_ch1.2
tmp[tmp=="Stage: advanced stage"] <- "late"
tmp[tmp=="Stage: early stage"] <- "early"
tmp[tmp==""] <- NA
curated$summarystage <- tmp

#debulking, all unknown
curated$debulking <- NA #was "unknown"

#tmp2 <- edit(curated) 

curated <- postProcess(curated)

write.table(curated, row.names=FALSE, file="../curated/GSE12470_curated_pdata.txt",sep="\t")
