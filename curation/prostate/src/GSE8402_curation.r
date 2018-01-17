rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE8402_full_pdata.csv",as.is=TRUE,row.names=1)


##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##alt_sample_name
tmp <- uncurated$title
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
curated$alt_sample_name <- tmp

##sample_type
curated$sample_type <-"tumor"

##fusion
tmp <- uncurated$characteristics_ch1.1
tmp1 <- uncurated$characteristics_ch1
tmp3 <- tmp
for (i in 1:length(tmp)){
if (tmp[i]== "DELETION: YES")
tmp2 <- "deletion"
else if (tmp1[i] == "FUSION: NO"| tmp1[i]== "FUSION:NO")
tmp2 <- "n"
else if (tmp1[i] == "FUSION: YES"| tmp1[i]== "FUSION:YES")
tmp2 <- "y"
else
tmp2 <- NA
tmp3[i] <- tmp2
}
curated$fusion. <- tmp3



#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE8402_curated_pdata.txt",sep="\t")
