rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE13876_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE13876/RAW"
uncurated1 <- read.csv("../uncurated/Copy_of_Patient_data_+_GEO_coupling_for_Haibe_Kains_GSE13876.csv",as.is=TRUE,row.names=1)

stopifnot( identical(rownames(uncurated), rownames(uncurated1)) )

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#sample_type
#subtype
#T
#age at initial diagnosis
#days_to_death
#vital_status

##title -> alt_sample_name
tmp <- uncurated$title
tmp <- sub("Ovarian tumor sample ","",tmp,fixed=TRUE)
curated$alt_sample_name <- tmp

##unique_patient_ID
tmp <- uncurated$characteristics_ch1
tmp <- sub("assigned unique patient id: ","",tmp,fixed=TRUE)
curated$unique_patient_ID <- tmp

##grade
tmp <- uncurated1$diff.grade
tmp <- as.numeric(tmp) 
tmp[tmp=="5"] <- NA
tmp[tmp=="6"] <- NA
tmp[tmp==""] <- NA
tmp[tmp==NA] <- NA
curated$G <- tmp 

##Note there is one patient with diff.grade disagreeing between
##technical replicates:
patient.grade <- tapply(curated$G, curated$unique_patient_ID, c)
(grade.inconsistencies <- patient.grade[ sapply(patient.grade, function(x) length(unique(x)) > 1) ])
##So for this patient, we use the maximum grade (3):
for (unique.patient.id in names(grade.inconsistencies))
    curated[curated$unique_patient_ID %in% unique.patient.id, "G"] <-
        max(grade.inconsistencies[[unique.patient.id]])

##sample_type are all tumor
curated$sample_type <- "tumor"

##subtype all are serous
curated$subtype <- "ser"

##primarysite all NA
curated$primarysite <- NA

##T are all advanced stage
curated$T <- "4"

##summarystage are all "late"
curated$summarystage <- "late"

##characteristics_ch1.3-> age_at_initial_pathologic_diagnosis
tmp <- uncurated$characteristics_ch1.3
tmp <- sub("age: ","",tmp,fixed=TRUE)
tmp <- as.numeric(tmp) 
curated$age_at_initial_pathologic_diagnosis <- tmp

#primarysite all "ov"?
curated$primarysite <- "ov"

##characteristics_ch1.2-> days_to_death.  This entry matches the
##median and range given in row 2 of Table 1 in the paper (median
##survival 21 months, range 1-234).
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("fumnd: ","",tmp,perl=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
#FUMND: Months from primary surgery 
curated$days_to_death <- tmp
 
##characteristics_ch1.1> vital_status
tmp <- uncurated$characteristics_ch1.1
tmp <- sub("status: ","",tmp,fixed=TRUE)
tmp[tmp=="0"] <- "living"
tmp[tmp=="1"] <- "deceased" 
curated$vital_status <- tmp

#debulking all unknown
curated$debulking <- NA   #was "unknown" 
  

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE13876_curated_pdata.txt",sep="\t")
