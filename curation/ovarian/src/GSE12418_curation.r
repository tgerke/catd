rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE12418_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE12418/RAW"

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

##primarysite are all ov?
curated$primarysite <- "ov"

##subtype all are serous
curated$subtype <- "ser"

##T all are "III"
curated$T <- "3"

##summarystage all are late
curated$summarystage <- "late"

##characteristics_ch1.2 -> substage
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("stage III","",tmp,fixed=TRUE)
tmp[tmp==""] <- NA
tmp[tmp=="ab"] <- "b"
curated$substage <- tmp

##characteristics_ch1.4 -> age_at_initial_pathologic_diagnosis
tmp <- uncurated$characteristics_ch1.4
tmp <- sub("age at diagnosis ","",tmp,fixed=TRUE)
tmp <- as.numeric(tmp)
curated$age_at_initial_pathologic_diagnosis <- tmp

##pltx all are yes
curated$pltx <- "y"

##characteristics_ch1.1 -> vital_status
tmp <- uncurated$characteristics_ch1.1
tmp[tmp=="5 year survivor"] <- "long"
tmp[tmp=="deceased"] <- "short"
curated$os_binary <- tmp

##characteristics_ch1.3 ->debulking
tmp <- uncurated$characteristics_ch1.3
tmp[tmp=="macroscopic residual tumor"] <- "suboptimal"
tmp[tmp=="no macroscopic residual tumor"] <- "optimal"
curated$debulking <- tmp
  

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE12418_curated_pdata.txt",sep="\t")
