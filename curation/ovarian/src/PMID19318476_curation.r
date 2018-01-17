rm(list=ls())
source("../../functions.R")

uncurated <- read.delim("../uncurated/PMID19318476_full_pdata.txt",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/PMID19318476/RAW"

celfile.names <- read.delim("../uncurated/PMID19318476_RAWfilenames.txt",as.is=TRUE,header=FALSE)[,1]
celfile.names <- sub("/home/lwaldron/svn/repos/DATA/PMID19318476/RAW/","",celfile.names)
celfile.names <- sub(".cel","",celfile.names,fixed=TRUE)

summary(rownames(uncurated)%in% celfile.names)
celfile.names[!celfile.names %in% rownames(uncurated)]

##Note: do not use any column with "Prediction" in its name.

##Need to get microarray data to see which identifiers to use.

##initial creation of curated dataframe
##curated <- data.frame(sample_name=rownames(uncurated))#,row.names=rownames(uncurated))
##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#days_to_death
#age_at_diagnosis
#T
#substage
#grade
#debulking

##Tumor  -> alt_sample_name
tmp <- uncurated$Tumor 
curated$alt_sample_name <- tmp

#Survival (months) -> days_to_death
tmp <- uncurated$Survival..months.
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_death <- tmp

#AgeDx-> age_at_diagnosis
tmp <- uncurated$AgeDx
curated$age_at_initial_pathologic_diagnosis <- tmp 

curated$sample_type <- "tumor"

##From the "Patients and Methods" section of the paper:
##"Microarray analysis was done on 101 serous ovarian cancers
##collected from the primary ovarian site (42 advanced stage III/IV,
##39 early stage I/II, 20 borderline"
curated$subtype <- "ser"

#STAGE -> T
tmp <- uncurated$STAGE
tmp <- gsub("[^IV]","",tmp,perl=TRUE)
tmp[tmp=="I"] <- "1"
tmp[tmp=="II"] <-"2"
tmp[tmp=="III"] <-"3"
tmp[tmp=="IV"] <-"4"
curated$T <- tmp

##summarystage
tmp <- uncurated$STAGE
tmp <- gsub("[^IV]","",tmp,perl=TRUE)
tmp[tmp=="I"] <- "early"
tmp[tmp=="II"] <-"early"
tmp[tmp=="III"] <- "late"
tmp[tmp=="IV"] <- "late"
tmp[tmp==""] <- NA
curated$summarystage <-tmp

#STAGE -> substage
tmp <- uncurated$STAGE
tmp <- gsub("[^ABC]","",tmp,perl=TRUE)
tmp[tmp=="A"] <-"a"
tmp[tmp=="B"] <- "b"
tmp[tmp=="C"] <- "c"
tmp[tmp==""] <- NA
curated$substage <- tmp

#GRADE -> grade
tmp <- uncurated$GRADE
curated$G <- tmp

#summarygrade -> grade
tmp <- uncurated$GRADE
tmp[tmp=="1"] <-"low"
tmp[tmp=="2"] <-"low"
tmp[tmp=="3"] <-"high"
tmp[tmp=="4"] <-"high"
curated$summarygrade <- tmp

##vital_status
tmp <- uncurated$Status
curated$vital_status <- ifelse(grepl("DOD|dead",tmp,ignore.case=TRUE),"deceased","living")
curated$vital_status[is.na(tmp)] <- NA

##recurrence_status
tmp <- uncurated$Status
curated$recurrence_status <- ifelse(grepl("DOD|AWD", tmp, ignore.case=TRUE), "recurrence", "norecurrence")
curated$recurrence_status[is.na(tmp)] <- NA 

##Debulking -> debulking
tmp <- uncurated$Debulk
tmp[tmp=="S"] <- "suboptimal"
tmp[tmp=="O"] <- "optimal"
tmp[tmp==""] <- NA
curated$debulking <- tmp
  

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/PMID19318476_curated_pdata.txt",sep="\t")
