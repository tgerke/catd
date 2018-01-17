source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE8842_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE8842/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")
##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
tmp <- sub("sample_Ovarian tumor ","",tmp,fixed=TRUE)
curated$alt_sample_name <- tmp

##sample_type are all tumor
curated$sample_type <- "tumor"

## characteristics_ch1.4-> subtype
tmp <- uncurated$characteristics_ch1.4
tmp <- sub("Histotype:","",tmp,fixed=TRUE)
tmp[tmp=="serous"] <- "ser"
tmp[tmp=="endometrioid"] <- "endo"
tmp[tmp=="clear cells"] <- "clearcell"
curated$subtype <- tmp

## characteristics_ch1.2-> T
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("FIGO Stage:","",tmp,fixed=TRUE)
curated$T <- tmp

##summarystage
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("FIGO Stage:","",tmp,fixed=TRUE)
tmp[tmp==""] <- NA
tmp[tmp=="1"] <-"early"
tmp[tmp=="2"] <-"early"
tmp[tmp=="3"] <-"late"
tmp[tmp=="4"] <-"late"
curated$summarystage <- tmp

##primarysite all "ov"?
curated$primarysite <- "ov"

## characteristics_ch1.3-> substage
tmp <- uncurated$characteristics_ch1.3
tmp <- sub("FIGO Substage:","",tmp,fixed=TRUE)
curated$substage <- tmp

## characteristics_ch1.5-> G
tmp <- uncurated$characteristics_ch1.5
tmp <- sub("Grade:","",tmp,fixed=TRUE)
tmp[tmp=="Borderline"] <- NA
curated$G <- tmp

##summarygrade
tmp <- uncurated$characteristics_ch1.5
tmp <- sub("Grade:","",tmp,fixed=TRUE)
tmp[tmp=="Borderline"] <- NA
tmp[tmp=="1"] <-"low"
tmp[tmp=="2"] <-"low"
tmp[tmp=="3"] <-"high"
tmp[tmp=="4"] <-"high"
curated$summarygrade <- tmp


## characteristics_ch1.7->age_at_initial_pathologic_diagnosis 
tmp <- uncurated$characteristics_ch1.7
tmp <- sub("Age(years):","",tmp,fixed=TRUE)
#tmp <-sub(".","", tmp, fixed=TRUE)
tmp <- as.numeric(tmp)
tmp <- round(tmp)
curated$age_at_initial_pathologic_diagnosis <- tmp

## characteristics_ch1.6-> recurrence_status 
tmp <- uncurated$characteristics_ch1.6
tmp <- sub("Relapsed:","",tmp,fixed=TRUE)
tmp[tmp=="yes"] <- "recurrence"
tmp[tmp=="no"] <- "norecurrence"
curated$recurrence_status <- tmp

##characteristics_ch1.8 -> days_to_death
tmp <- uncurated$characteristics_ch1.8
tmp <- sub("Overall Survival(days):","",tmp,fixed=TRUE)
curated$days_to_death <- tmp

##characteristics_ch1.1 -> vital_status
tmp <- uncurated$characteristics_ch1.1
tmp <- sub("Status:","",tmp,fixed=TRUE)
tmp[tmp=="death related to cancer"] <- "deceased"
tmp[tmp=="alive no evidence of disease"] <- "living"
tmp[tmp=="death unrelated to cancer"] <- "deceased"
tmp[tmp=="in progression"] <- "living"
curated$vital_status <- tmp

##debulking all are unknown
curated$debulking <- NA  #was "unknown"
  

curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE8842_curated_pdata.txt",sep="\t")
