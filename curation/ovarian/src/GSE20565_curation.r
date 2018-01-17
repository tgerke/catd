rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE20565_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE20565/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")
##--------------------
##start the mappings
##--------------------
#title -> alt_sample_name
tmp <- uncurated$title 
curated$alt_sample_name <- tmp

#sample_type all tumor
curated$sample_type <- "tumor"

#characteristics_ch1.3 -> subtype
tmp <- uncurated$characteristics_ch1.3
tmp <- sub("histotype: ","",tmp,fixed=TRUE)
tmp[tmp=="Serous"] <- "ser"
tmp[tmp=="Endometrioid"] <- "endo"
tmp[tmp=="N/A"] <- NA
tmp[tmp=="Mucinous"] <- "mucinous"
tmp[tmp=="Clear Cells"] <- "clearcell"
tmp[tmp=="Adenocarcinoma"] <- "other"
tmp[tmp==""] <- NA
tmp[tmp=="NA"] <- NA
tmp[tmp=="Brenner Tumor"] <- "other"
tmp[tmp=="Carcinosarcoma"] <- "other"
tmp[tmp=="Carcinosarcome"] <- "other"
curated$subtype <- tmp

##primarysite
tmp <- uncurated$source_name_ch1
tmp[tmp=="Ovarian carcinoma"] <- "ov"
tmp[tmp=="Plausible Ovarian carcinoma"] <- "ov"
tmp[tmp=="Plausible Breast metastasis in the ovary"] <- "other"
tmp[tmp=="Breast metastasis in the ovary"] <- "other"
tmp[tmp=="Ovarian Carcinoma"] <- "ov"
curated$primarysite <- tmp

#debulking all unknown
curated$debulking <- NA #was "unknown"

#characteristics_ch1.6 -> T
  #tmp "stade: ", ""
  #keep IV, remove else (ie abc)
tmp <- uncurated$characteristics_ch1.6 
tmp <- sub("stade: ","",tmp,fixed=TRUE)
tmp <- sub("[abc]$","",tmp)
tmp[tmp=="I"] <- "1"
tmp[tmp=="II"] <- "2"
tmp[tmp=="III"] <- "3"
tmp[tmp=="IV"] <- "4"
tmp[tmp=="N/A"] <- NA
tmp[tmp==""] <- NA
curated$T <- tmp

##summarystage
tmp <- uncurated$characteristics_ch1.6 
tmp <- sub("stade: ","",tmp,fixed=TRUE)
tmp <- sub("[abc]$","",tmp)
tmp[tmp=="I"] <- "early"
tmp[tmp=="II"] <- "early"
tmp[tmp=="III"] <- "late"
tmp[tmp=="IV"] <- "late"
tmp[tmp=="N/A"] <- NA
tmp[tmp==""] <- NA
curated$summarystage <- tmp

#characteristics_ch1.6 -> substage
tmp <- uncurated$characteristics_ch1.6 
tmp <- sub("stade: ","",tmp,fixed=TRUE)
tmp <- gsub("[IV]","",tmp)
#tmp[tmp==""] <- NA
tmp[tmp=="N/A"] <- NA
tmp[tmp==""] <- NA
curated$substage <- tmp

#characteristics_ch1.5 -> G
tmp <- uncurated$characteristics_ch1.5 
tmp <- sub("grade: ","",tmp,fixed=TRUE)
tmp[tmp=="N/A"] <- NA
tmp[tmp==""] <- NA
curated$G <- tmp

##summarygrade
tmp <- uncurated$characteristics_ch1.5 
tmp <- sub("grade: ","",tmp,fixed=TRUE)
tmp[tmp=="N/A"] <- NA
tmp[tmp==""] <- NA
tmp[tmp=="1"] <-"low"
tmp[tmp=="2"] <-"low"
tmp[tmp=="3"] <-"high"
tmp[tmp=="4"] <-"high"
curated$summarygrade <- tmp
  
#characteristics_ch1.4 -> M
tmp <- uncurated$characteristics_ch1.4
tmp[tmp=="tumor/metastasis: T"] <- "0"
tmp[tmp=="tumor/metastasis: M"] <- "1" 
curated$M <- tmp




curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE20565_curated_pdata.txt",sep="\t")
