rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/PMID15897565_arrayWebSiteClinicalData2005.csv",as.is=TRUE)#, row.names=1)

celfile.dir <- "../../../DATA/PMID15897565/RAW"

##match up column 1 of the uncurated data with a component of the celfiles:
celfile.names <- dir("../../../DATA/PMID15897565/RAW",pattern="cel$")
celfile.matches <- sapply(uncurated[,1],function(x) grep(paste("0074_",x,sep=""),celfile.names,val=TRUE))
names(celfile.matches) <- uncurated[,1]
removeme <- sapply(celfile.matches,length) != 1
uncurated <- uncurated[!removeme,]
celfile.matches <- celfile.matches[!removeme]
rownames(uncurated) <- sub(".cel","",celfile.matches,fixed=TRUE)

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#days_to_death
#os_binary
#age_at_diagnosis
#T
#substage
#grade
#debulking

##Genome ID  -> alt_sample_name
tmp <- uncurated$Genome.ID 
curated$alt_sample_name <- tmp

curated$sample_type <- "tumor"

##From the Materials and Methods Patients and tissue acquisition
##section: "Invasive serous ovarian cancer tissue was snap-frozen at
##initial surgery before any chemotherapy in 65 women treated at Duke"
curated$subtype <- "ser"

#Cancer Type -> days_to_death
#tmp <- uncurated$Cancer.Type
#tmp[tmp=="Long"] <- "survival > 7 yrs"
#365*7
#tmp[tmp=="Long"] <- "2555"
#tmp[tmp=="Short"] <- "survival < 3 yrs"
#364*3
#tmp[tmp=="Short"] <- "1092"
#tmp[tmp=="Early stage"] <- NA
#curated$days_to_death <- tmp

#Cancer Type -> os_binary
tmp <- uncurated$Cancer.Type
tmp[tmp=="Early stage"] <- NA
tmp[tmp=="Long"] <- "long"
tmp[tmp=="Short"] <- "short"
curated$os_binary <- tmp

#primarysite all "ov"?
curated$primarysite <- "ov"

#AgeDx -> age_at_initial_pathologic_diagnosis
tmp <- uncurated$AgeDx
curated$age_at_initial_pathologic_diagnosis <- tmp 

#STAGE -> T
tmp <- uncurated$STAGE
tmp <- gsub("[^IV]","",tmp,perl=TRUE)
tmp[tmp=="I"] <- "1"
tmp[tmp=="II"] <- "2"
tmp[tmp=="III"] <- "3"
tmp[tmp=="IV"] <- "4"
curated$T <- tmp

##summarystage
tmp <- uncurated$STAGE
tmp <- gsub("[^IV]","",tmp,perl=TRUE)
tmp[tmp=="I"] <- "early"
tmp[tmp=="II"] <- "early"
tmp[tmp=="III"] <- "late"
tmp[tmp=="IV"] <- "late"
curated$summarystage <- tmp

#STAGE -> substage
tmp <- uncurated$STAGE
tmp <- gsub("[^abc]","",tmp,perl=TRUE)
curated$substage <- tmp

#GRADE -> G
tmp <- uncurated$GRADE
tmp[tmp=="?"] <- NA
curated$G <- tmp

##summarygrade
tmp <- uncurated$GRADE
tmp[tmp=="?"] <- NA
tmp[tmp=="1"] <-"low"
tmp[tmp=="2"] <-"low"
tmp[tmp=="3"] <-"high"
tmp[tmp=="4"] <-"high"
curated$summarygrade <- tmp

#Debulking -> debulking
tmp <- uncurated$Debulking
tmp[tmp=="S"] <- "suboptimal"
tmp[tmp=="O"] <- "optimal"
tmp[tmp==" "] <- NA #was "unknown"
curated$debulking <- tmp

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/PMID15897565_curated_pdata.txt",sep="\t")
