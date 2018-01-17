source("../../functions.R")

uncurated1 <- read.csv("../uncurated/GSE9891_full_pdata.csv",as.is=TRUE,row.names=1)
uncurated2 <- read.csv("../uncurated/GSE9891_SuppTable.csv",as.is=TRUE)
celfile.dir <- "../../../DATA/GSE9891/RAW"

uncurated2$ID <- paste("X",uncurated2$ID,sep="")
uncurated2 <- uncurated2[match(uncurated1$title,uncurated2$ID),]
(MatchWasSuccessful <- all.equal(uncurated1$title,uncurated2$ID))

if(MatchWasSuccessful){
  uncurated <- cbind(uncurated1,uncurated2)
}

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

##--------------------
##start the mappings
##--------------------

#title-> alt_sample_name
#sample_type
  #all tumor
#HistologicalSubtype -> subtype
#PrimarySite -> primarysite
#FIGOStage -> T
#characteristics_ch1.3 -> substage
#Grade -> grade
#PatientAge.Years. -> age_at_diagnosis
#PatientStatus -> vital_status
  #D, died; D*, died of other causes; R, alive and relapsed; PF, alive and progression-free
#Pltx -> Pltx
#Tax -> Tax
#Neo -> Neo
#TimeToRelapseorLastFollow.Up.Months. -> days_to_tumor_recurrence
#TimeToDeathorLastFollow.Up.Months. -> days_to_death
#tumor_residual_disease -> ResidualDisease
#ArrayedSite -> arrayedsite

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type are all tumor
curated$sample_type <- "tumor"

##HistologicalSubtype ->  subtype
tmp <- uncurated$HistologicalSubtype
tmp[tmp=="Ser"] <- "ser"
tmp[tmp=="Endo"] <- "endo"
tmp[tmp=="Adeno"] <- "other"
curated$subtype <- tmp

##PrimarySite ->  primarysite
tmp <- uncurated$PrimarySite
tmp[tmp=="OV"] <- "ov"
tmp[tmp=="PE"] <- "other"
tmp[tmp=="FT"] <- "ft"
tmp[tmp=="CO"] <- "other"
tmp[tmp=="UT"] <- "other"
tmp[tmp=="OM"] <- "other"
tmp[tmp=="Other"] <- "other"
curated$primarysite <- tmp

#FIGOStage -> T
tmp <- uncurated$FIGOStage
tmp[tmp=="I"] <- "1"
tmp[tmp=="II"] <- "2"
tmp[tmp=="III"] <- "3"
tmp[tmp=="IV"] <- "4"
curated$T <- tmp

##summarystage
tmp <- uncurated$FIGOStage
tmp[tmp==""] <- NA
tmp[tmp=="I"] <- "early"
tmp[tmp=="II"] <- "early"
tmp[tmp=="III"] <- "late"
tmp[tmp=="IV"] <- "late"
tmp[tmp=="3"] <- "late"
curated$summarystage <- tmp

#characteristics_ch1.3 -> substage
tmp <- uncurated$characteristics_ch1.3
tmp <- sub("StageCode : ","",tmp,fixed=TRUE)
tmp <- gsub("[^ABC]","",tmp)
tmp[tmp=="A"] <- "a"
tmp[tmp=="B"] <- "b"
tmp[tmp=="C"] <- "c"
tmp[tmp==""] <- NA
curated$substage <- tmp

#Grade -> G
tmp <- uncurated$Grade
curated$G <- tmp

##summarygrade
tmp <- uncurated$Grade
tmp[tmp=="1"] <-"low"
tmp[tmp=="2"] <-"low"
tmp[tmp=="3"] <-"high"
tmp[tmp=="4"] <-"high"
curated$summarygrade <- tmp



#PatientAge.Years. -> age_at_initial_pathologic_diagnosis
tmp <- uncurated$PatientAge.Years.
curated$age_at_initial_pathologic_diagnosis <- tmp

#PatientStatus -> vital_status
  #D, died; D*, died of other causes; R, alive and relapsed; PF, alive and progression-free
tmp <- uncurated$PatientStatus
#tmp[tmp=="D"] <- "deceased"
#tmp[tmp=="D*"] <- "deceased of other causes"
#tmp[tmp=="R"] <- "alive and relapsed"
#tmp[tmp=="PF"] <- "alive and progression-free"
tmp[tmp=="D"] <- "deceased"
tmp[tmp=="D*"] <- "deceased"
tmp[tmp=="R"] <- "living"
tmp[tmp=="PF"] <- "living"
tmp[tmp==""] <- NA
curated$vital_status <- tmp

#PatientStatus -> recurrence_status
  #D, died; D*, died of other causes; R, alive and relapsed; PF, alive and progression-free
tmp <- uncurated$PatientStatus
tmp[tmp=="D"] <- "recurrence"
tmp[tmp=="D*"] <- "norecurrence"
tmp[tmp=="R"] <- "recurrence"
tmp[tmp=="PF"] <- "norecurrence"
tmp[tmp==""] <- NA
curated$recurrence_status <- tmp
  
#Pltx -> pltx
tmp <- uncurated$Pltx
tmp[tmp=="Y"] <- "y"
tmp[tmp=="N"] <- "n"
tmp[tmp==""] <- NA
curated$pltx <- tmp

#Tax -> tax
tmp <- uncurated$Tax
tmp[tmp=="Y"] <- "y"
tmp[tmp=="N"] <- "n"
tmp[tmp==""] <- NA 
curated$tax  <- tmp

#Neo -> neo
tmp <- uncurated$Neo
tmp[tmp=="Y"] <- "y"
tmp[tmp=="N"] <- "n"
tmp[tmp==""] <- NA
curated$neo <- tmp

#TimeToRelapseorLastFollow.Up.Months. -> days_to_tumor_recurrence
tmp <- uncurated$TimeToRelapseorLastFollow.Up.Months.
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_tumor_recurrence <- tmp

#TimeToDeathorLastFollow.Up.Months. -> days_to_death
tmp <- uncurated$TimeToDeathorLastFollow.Up.Months.
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_death <- tmp

#ResidualDisease ->debulking
tmp <- uncurated$ResidualDisease
tmp[tmp=="nil"] <- "optimal"
tmp[tmp==">1"] <- "suboptimal"
tmp[tmp=="macrosizeNK"] <- "suboptimal"
tmp[tmp=="<1"] <- "optimal"
tmp[tmp=="NK"] <- NA #was "unknown"
tmp[tmp=="nil"] <- "optimal"
curated$debulking <- tmp

#ArrayedSite -> arrayedsite
tmp <- uncurated$ArrayedSite
tmp[tmp=="OV"] <- "ov"
tmp[tmp=="PE"] <- "other"
tmp[tmp=="FT"] <- "ft"
tmp[tmp=="CO"] <- "other"
tmp[tmp=="UT"] <- "other"
tmp[tmp=="OM"] <- "other"
tmp[tmp=="BN"] <- "other"
tmp[tmp=="OvorOM"] <- "other"
tmp[tmp=="Other"] <- "other"
curated$arrayedsite <- tmp


curated <- postProcess(curated)

write.table(curated,row.names=FALSE, file="../curated/GSE9891_curated_pdata.txt",sep="\t")
