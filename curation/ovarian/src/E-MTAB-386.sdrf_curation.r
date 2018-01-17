rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/E-MTAB-386.sdrf.csv",as.is=TRUE)
uncurated <- uncurated[-grep("miRNA",uncurated$Scan.Name),]  #get rid of miRNA samples
rownames(uncurated) <- make.names(sub("RNA-hyb-","",uncurated$Scan.Name))  ##get rid of RNA-hyb- from Scan.Name column, then convert to legal R names, and use this for the rownames.  
    
##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

##--------------------
##start the mappings
##--------------------


##unique patient ID
tmp <- curated$sample_name
tmp <- sub(".rep1","",tmp,fixed=TRUE)
tmp <- sub(".rep2","",tmp,fixed=TRUE)
curated$unique_patient_ID <- tmp

#age
tmp <- uncurated$Characteristics.Age
tmp <- gsub("[^\\d+.]","",tmp,perl=TRUE)
tmp <- as.numeric(tmp)
tmp <- as.integer(round(tmp))
curated$age_at_initial_pathologic_diagnosis <- tmp

curated$subtype <- "ser"

curated$sample_type <- "tumor"

#primarysite all "ov"?
curated$primarysite <- "ov"

#stage
tmp <- uncurated$Characteristics.DiseaseStage
tmp <- gsub("[a-d]","",tmp,perl=TRUE)
tmp[tmp=="III"] <- "3"
tmp[tmp=="IV"] <- "4"
tmp[tmp=="Ii"] <- NA
curated$T <- tmp

#substage
tmp <- uncurated$Characteristics.DiseaseStage
tmp <- gsub("[^a-d]","",tmp,perl=TRUE)
tmp[tmp==""] <- NA
curated$substage <- tmp

#summarystage
tmp <- uncurated$Characteristics.DiseaseStage
tmp <- gsub("[a-d]","",tmp,perl=TRUE)
tmp[tmp=="III"] <- "late"
tmp[tmp=="IV"] <- "late"
tmp[tmp=="Ii"] <- NA
curated$summarystage <- tmp

#days_to_death
tmp <- uncurated$Characteristics.SurvivalTime
tmp <- gsub("[^\\d+.]","",tmp,perl=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp*30 #make months into days
curated$days_to_death <- tmp

#debulking
tmp <- uncurated$Characteristics.OptimalDebulking
tmp[tmp=="Yes"] <- "optimal"
tmp[tmp=="No"] <- "suboptimal"
tmp[tmp=="Unknown"] <- NA   #was "unknown"
curated$debulking <- tmp

#vital_status
tmp <- uncurated$Characteristics.EventDeath
tmp[tmp=="0"] <- "living"
tmp[tmp=="1"] <- "deceased"
curated$vital_status <- tmp

  

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/E-MTAB-386_curated_pdata.txt",sep="\t")
