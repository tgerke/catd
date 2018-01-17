rm(list=ls())

source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE6008_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE6008/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##characteristics_ch1 -> sample_type
tmp <- uncurated$characteristics_ch1
tmp <- sub("Tumor_Type: ","",tmp,fixed=TRUE)
tmp[tmp=="N/A"] <- "healthy"
tmp[tmp=="Clear_Cell"]<- "tumor"
tmp[tmp=="Endometrioid"]<- "tumor"
tmp[tmp=="Serous"]<- "tumor"
tmp[tmp=="Mucinous"]<- "tumor"
tmp[tmp==""] <- NA
tmp[tmp=="N/A"] <- NA
curated$sample_type <- tmp

#primarysite all NA
curated$primarysite <- NA

##characteristics_ch1 -> subtype
tmp <- uncurated$characteristics_ch1
tmp <- sub("Tumor_Type: ","",tmp,fixed=TRUE)
tmp[tmp=="Clear_Cell"]<- "clearcell"
tmp[tmp=="Endometrioid"]<- "endo"
tmp[tmp=="Serous"]<- "ser"
tmp[tmp=="Mucinous"]<- "mucinous"
tmp[tmp==""] <- NA  #was "unknown"
tmp[tmp=="N/A"] <- NA #was "unknown"
curated$subtype <- tmp

##characteristics_ch1.1 -> T
tmp <- uncurated$characteristics_ch1.1
#tmp <- sub("tissue: Late-stage high-grade ovarian cancer","late",tmp,fixed=TRUE)
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp[tmp=="N/A"] <- NA
curated$T <- tmp

##characteristics_ch1.1 -> summarystage
tmp <- uncurated$characteristics_ch1.1
#tmp <- sub("tissue: Late-stage high-grade ovarian cancer","late",tmp,fixed=TRUE)
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp[tmp=="N/A"] <- NA
tmp[tmp=="1"] <-"early"
tmp[tmp=="2"] <-"early"
tmp[tmp=="3"] <-"late"
tmp[tmp=="4"] <-"late"
tmp[tmp==""] <- NA
curated$summarystage <- tmp


##characteristics_ch1.1 -> substage
tmp <- uncurated$characteristics_ch1.1
tmp <- sub("stage: ","",tmp,fixed=TRUE)
tmp <- gsub("[^\\D]","",tmp,perl=TRUE)
tmp[tmp=="A"] <- "a"
tmp[tmp=="B"] <- "b"
tmp[tmp=="C"] <- "c"
tmp[tmp=="D"] <- "d"
tmp[tmp=="I c"] <- "c"
tmp[tmp=="I a"] <- "a"
tmp[tmp==""] <- NA
tmp[tmp=="N/A"] <- NA
curated$substage <- tmp

##primarysite, all ov?
curated$primarysite <- "ov"

##characteristics_ch1.2 -> G
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("grade: ","",tmp,fixed=TRUE)
tmp[tmp=="2-3"] <- "3"
tmp[tmp==""] <- NA
tmp[tmp=="N/A"] <- NA
curated$G <- tmp

##summarygrade
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("grade: ","",tmp,fixed=TRUE)
tmp[tmp=="2-3"] <- "high"
tmp[tmp==""] <- NA
tmp[tmp=="N/A"] <- NA
tmp[tmp=="1"] <-"low"
tmp[tmp=="2"] <-"low"
tmp[tmp=="3"] <-"high"
tmp[tmp=="4"] <-"high"
curated$summarygrade <- tmp

##debulking all unknown
curated$debulking <- NA  #was "unknown"
 
#tmp2 <- edit(curated) 

curated <- postProcess(curated)

write.table(curated, row.names=FALSE, file="../curated/GSE6008_curated_pdata.txt",sep="\t")
