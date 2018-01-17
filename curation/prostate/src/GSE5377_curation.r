rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE5377_full_pdata.csv",as.is=TRUE,row.names=1)


##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

#curated$alt_sample_name <- curate_title

##age
curated$age_at_initial_pathologic_diagnosis <- curate_age(uncurated$characteristics_ch1.1)

#sample_type
tmp <- uncurated$source_name_ch1
tmp[tmp=="human prostate cancer of untreated patient"] <- "tumor"
tmp[tmp=="BPH of untreated patient"] <- "healthy"
tmp[tmp=="human prostate cancer of hormone sensitive patient treated with LHRH"] <- "tumor"
tmp[tmp=="human prostate cancer treated with complete androgen blockade (CAB)"] <- "tumor"
tmp[tmp=="prostate cancer resistant against complete androgen blockade (CAB)"] <- "tumor"
tmp[tmp=="hormone resistant prostate cancer under LHRH treatment after androgen withrawal"] <- "tumor"
tmp[tmp=="BPH of patient treated with LHRH"] <- "adjacentnormal"
curated$sample_type <- tmp

#source_type
tmp <- uncurated$treatment_protocol_ch1
tmp[tmp=="radical prostatectomy"] <- "prostatectomy"
tmp[tmp=="transurethral resection (TUR)"] <- "TURP"
tmp[tmp=="radical prostatectomy and in vitro TUR"] <- "prostatectomy_and_TURP"
curated$sample_type.1 <- tmp

#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE5377_curated_pdata.txt",sep="\t")
