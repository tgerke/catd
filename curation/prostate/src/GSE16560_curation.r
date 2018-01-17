rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE16560_full_pdata.csv",as.is=TRUE,row.names=1)


##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type
curated$sample_type <- "tumor"

#gleasongrade
#tmp <- uncurated$characteristics_ch1.1
#tmp1 <- uncurated$characteristics_ch1.2
#tmp <- as.character(as.numeric(gsub("[^\\d]","",tmp,perl=TRUE)))
#tmp1 <- as.character(as.numeric(gsub("[^\\d]","",tmp1,perl=TRUE)))
#tmp3 <- data.frame(tmp, tmp1)
#curated$gleasongrade <- paste(tmp3[,'tmp'], tmp3[,'tmp1'], sep='+')
tmp <- uncurated$characteristics_ch1
tmp <- sub("gleason: ", "", tmp, fixed = TRUE) 
curated$gleasongrade <- tmp

#summarygrade
tmp <- uncurated$characteristics_ch1
tmp <- as.numeric(gsub("[^\\d]","",tmp,perl=TRUE))
tmp[tmp=="6"] <- "low"
tmp[tmp=="7"] <- "intermediate"
tmp[tmp=="8"] <- "high"
tmp[tmp=="9"] <- "high"
tmp[tmp=="10"] <- "high"
curated$summarygrade <- tmp

#age_at_initial_pathologic_diagnosis
tmp <- uncurated$characteristics_ch1.6
tmp <- sub("age:", "", tmp, fixed = TRUE)
curated$age_at_initial_pathologic_diagnosis <- tmp

#vital_status
tmp <- uncurated$characteristics_ch1.8
tmp[tmp=="status.all: Alive"] <- "living"
tmp[tmp=="status.all: Dead"] <- "deceased"
curated$vital_status <- tmp

#days_to_death
tmp <- uncurated$characteristics_ch1.9
tmp <- sub("fup.month: ", "", tmp, fixed = TRUE)    
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_death <- tmp

#fusion
#assuming that 0 goes to "n" and 1 goes to "y"
tmp <- uncurated$characteristics_ch1.10
tmp[tmp=="fusion: 0"] <- "n"
tmp[tmp=="fusion: 1"] <- "y"
tmp[tmp=="fusion: NA"] <- NA
curated$fusion.<- tmp


#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE16560_curated_pdata.txt",sep="\t")
