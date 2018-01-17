rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE17260_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE17260/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

##--------------------
##start the mappings
##--------------------

##characteristics_ch1 -> alt_sample_name
tmp <- uncurated$characteristics_ch1
tmp <- sub("sample id: ","",tmp,fixed=TRUE)
curated$alt_sample_name <- tmp

##sample_type are all tumor
curated$sample_type <- "tumor"

##primary_site not provided
curated$primarysite <- NA

##characteristics_ch1.5 -> days_to_death
tmp <- uncurated$characteristics_ch1.5
tmp <- sub("overall survival (m): ","",tmp,fixed=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_death <- tmp

##characteristics_ch1.6 -> vital_status
tmp <- uncurated$characteristics_ch1.6
tmp <- sub("death (1): ","",tmp,fixed=TRUE)
tmp[tmp=="0"] <- "living"
tmp[tmp=="1"] <- "deceased"
curated$vital_status <- tmp

##characteristics_ch1.3 -> days_to_tumor_recurrence
tmp <- uncurated$characteristics_ch1.3
tmp <- sub("progression-free survival (m): ","",tmp,fixed=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_tumor_recurrence <- tmp

##characteristics_ch1.4 -> recurrence_status
tmp <- uncurated$characteristics_ch1.4
tmp <- sub("recurrence (1): ","",tmp,fixed=TRUE)
tmp[tmp=="0"] <- "norecurrence"
tmp[tmp=="1"] <- "recurrence"
curated$recurrence_status <- tmp

##characteristics_ch1.2 -> tumor_residual_disease
#tmp <- uncurated$characteristics_ch1.2
#tmp[tmp=="cytoreductive surgery: optimal"] <- "no macroscopic disease"
#tmp[tmp=="cytoreductive surgery: not optimal"] <- "1-10mm"
#curated$tumor_residual_disease <- tmp

##characteristics_ch1.7 -> subtype
tmp <- uncurated$characteristics_ch1.7
tmp[tmp=="disease state: serous ovarian cancer"] <- "ser"
curated$subtype <- tmp

#primarysite all "ov"?
curated$primarysite <- "ov"

##characteristics_ch1.1 -> T
tmp <- uncurated$characteristics_ch1.1
tmp <- sub("stage: ","",tmp,fixed=TRUE)
tmp <- sub("[abc]$","",tmp)
tmp <- mapstage(tmp)
tmp[tmp==""] <- NA
curated$T <- tmp

##summarystage
tmp <- uncurated$characteristics_ch1.1
tmp <- sub("stage: ","",tmp,fixed=TRUE)
tmp <- sub("[abc]$","",tmp)
tmp <- mapstage(tmp)
tmp[tmp==""] <- NA
tmp[tmp=="1"] <-"early"
tmp[tmp=="2"] <-"early"
tmp[tmp=="3"] <-"late"
tmp[tmp=="4"] <-"late"
curated$summarystage <- tmp

##characteristics_ch1.1 -> substage
tmp <- uncurated$characteristics_ch1.1
tmp <- sub("stage: ","",tmp,fixed=TRUE)
tmp <- gsub("[IV]","",tmp)
tmp[tmp==""] <- NA
curated$substage <- tmp

##pltx all are yes
curated$pltx <- "y"

##tax all are yes
curated$tax <- "y"

##characteristics_ch1.2 -> debulking
tmp <- uncurated$characteristics_ch1.2
tmp[tmp=="cytoreductive surgery: optimal"] <- "optimal"
tmp[tmp=="cytoreductive surgery: not optimal"] <- "suboptimal"
curated$debulking <- tmp
  

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE17260_curated_pdata.txt",sep="\t")
