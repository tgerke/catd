rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/PMID14706684_Lancaster_clinical_info_data.csv",as.is=TRUE)
uncurated <- uncurated[,1:2]  ##get rid of other columns which are just blank
uncurated <- uncurated[uncurated$File.name != "",]  ##get rid of rows that are missing the sample name.

celfile.dir <- "../../../DATA/PMID14706684/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#os_binary


##File name -> alt_sample_name
tmp <- uncurated$File.name
tmp[tmp==""] <- NA
curated$alt_sample_name <- tmp

##subtype all NA
curated$subtype <- NA

##primarysite all ov?
curated$primarysite <- "ov"

##Survival ->sample_type
tmp <- uncurated$Survival
tmp[tmp=="long"] <- "tumor"
tmp[tmp=="short"] <-"tumor"
tmp[tmp=="control cell line"] <- "cellline"
tmp[tmp==""] <- NA
curated$sample_type <- tmp

##Survival -> os_binary
tmp <- uncurated$Survival
tmp[tmp=="control cell line"] <- NA
tmp[tmp==""] <- NA
curated$os_binary <- tmp

#debulking all unknown
curated$debulking <- NA #was "unknown"
  

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/PMID14706684_curated_pdata.txt",sep="\t")
