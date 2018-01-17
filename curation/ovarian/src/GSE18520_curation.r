rm(list=ls())

source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE18520_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE18520/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")
##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
tmp <- sub("Ovarian Tumor, ","",tmp,fixed=TRUE)
tmp <- sub("Normal Ovary, ","",tmp,fixed=TRUE)
curated$alt_sample_name <- tmp

##source_name_ch1 -> sample_type
tmp <- uncurated$source_name_ch1
tmp <- sub("papillary serous ovarian adenocarcinoma","tumor",tmp,fixed=TRUE)
tmp <- sub("normal ovarian surface epithelium (OSE)","healthy",tmp,fixed=TRUE)
curated$sample_type <- tmp

##primary_site are all ov
curated$primarysite <- "ov"

##characteristics_ch1.3-> days_to_death
tmp <- uncurated$characteristics_ch1.3
#tmp <- sub("surv data: ","",tmp,fixed=TRUE)
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_death <- tmp

##characteristics_ch1 -> subtype
tmp <- uncurated$characteristics_ch1
tmp <- sub("tissue: ", "",tmp,fixed=TRUE)
tmp[tmp=="papillary serous ovarian adenocarcinoma"] <- "ser"
tmp[tmp=="ovarian surface epithelium (OSE)"] <- "NA"
curated$subtype <- tmp

##characteristics_ch1.1 -> T
tmp <- uncurated$characteristics_ch1.1
tmp <- sub("tumor stage: ", "",tmp,fixed=TRUE)
tmp[tmp==""] <- NA
#p. 524: 53 optimally debulked stage III grade 3 serous adenocarcinoma
tmp[tmp=="late"] <- "3"
curated$T <- tmp

##summarystage
tmp <- uncurated$characteristics_ch1.1
tmp <- sub("tumor stage: ", "",tmp,fixed=TRUE)
tmp[tmp==""] <- NA
tmp[tmp=="late"] <- "late"
curated$summarystage <- tmp

##characteristics_ch1.2 -> G
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("tumor grade: ", "",tmp,fixed=TRUE)
tmp[tmp==""] <- NA
#p. 524: 53 optimally debulked stage III grade 3 serous adenocarcinoma
tmp[tmp=="high"] <- "3"
curated$G <- tmp

##summarygrade
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("tumor grade: ", "",tmp,fixed=TRUE)
tmp[tmp==""] <- NA
tmp[tmp=="high"] <- "high"
curated$summarygrade <- tmp

##characteristics_ch1.2 -> G_added_by_Ben_via_reading_paper
##tmp <- uncurated$characteristics_ch1.2
##tmp <- sub("tumor grade: high", "3",tmp,fixed=TRUE)
##curated$G_added_by_Ben_via_reading_paper <- tmp

##characteristics_ch1.3-> vital_status
tmp <- uncurated$characteristics_ch1.3
tmp[tmp==""] <- "NA"
tmp <- sub("surv data: ", "",tmp,fixed=TRUE)
tmp <- gsub("[^\\D]","",tmp,perl=TRUE)
#tmp <- sub("(A)", "living",tmp,fixed=TRUE)
tmp[tmp==" (A)"] <- "living"
tmp[tmp==""] <- "deceased"
curated$vital_status <- tmp

#p. 524: 53 optimally debulked stage III grade 3 serous adenocarcinoma
curated$debulking <- "optimal"
 
#tmp2 <- edit(curated) 

curated <- postProcess(curated)

write.table(curated, row.names=FALSE, file="../curated/GSE18520_curated_pdata.txt",sep="\t")
