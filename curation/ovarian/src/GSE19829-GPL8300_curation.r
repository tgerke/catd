rm(list=ls())

source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE19829-GPL8300_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE19829-GPL8300/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")
##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type are all "tumor"
curated$sample_type <- "tumor"

#primarysite all "ov"?
curated$primarysite <- "ov"

#debulking all unknown
curated$debulking <- NA #was "unknown"

##characteristics_ch1 -> days_to_death
tmp <- uncurated$characteristics_ch1
#tmp <- sub("overall survival (months): ","",tmp,fixed=TRUE)
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_death <- tmp

##characteristics_ch1.1-> vital_status
tmp <- uncurated$characteristics_ch1.1
#tmp <- sub("overall survival event: ", "",tmp,fixed=TRUE)
tmp <- gsub("[^\\d]","",tmp,perl=TRUE) 
tmp[tmp=="0"] <- "living"
tmp[tmp=="1"] <- "deceased"
curated$vital_status <- tmp
 
#tmp2 <- edit(curated) 

curated <- postProcess(curated)

write.table(curated, row.names=FALSE, file="../curated/GSE19829-GPL8300_curated_pdata.txt",sep="\t")
