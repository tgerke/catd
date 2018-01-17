rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE25136_full_pdata.csv",as.is=TRUE,row.names=1)


##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

#sample_type
tmp <- uncurated$characteristics_ch1.2
curated$sample_type <- "tumor"

#recurrence_status
tmp <- uncurated$characteristics_ch1.1
tmp[tmp=="recurrence status: Recurrent"] <- "recurrence"
tmp[tmp=="recurrence status: Non-Recurrent"] <- "norecurrence"
curated$recurrence_status <- tmp



#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE25136_curated_pdata.txt",sep="\t")
