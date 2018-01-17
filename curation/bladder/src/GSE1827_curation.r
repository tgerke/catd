rm(list=ls())
source("../../functions.R")
getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE1827_Clinical.csv",as.is=TRUE)
idmapping <- read.csv("../uncurated/GSE1827_geomapping.csv",as.is=TRUE)

idmapping[,2] = as.numeric(gsub("UR","",idmapping[,2]))
rownames(uncurated) = idmapping[match(uncurated[,1], idmapping[,2]),1]

uncurated = uncurated[order(rownames(uncurated)),]

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_bladder.csv")

##--------------------
##start the mappings
##--------------------

##alt_sample_name
curated$alt_sample_name <- uncurated$UR.

##sample_type are all tumor
curated$sample_type <- "tumor"

curated$surgery_type <- ifelse(uncurated$surgery.Type=="TURBT", "turbt", "rc")

##subtype
curated$histological_type <- ifelse(uncurated$histology == "scc ", "squamous", "tcc")


##Pathological T: -> T
curated$T <- as.numeric(gsub("a", 0, substr(uncurated$stage,3,3)))

##Pathological T: -> summarystage
tmp <- ifelse(curated$T < 2, "superficial", "invasive")
curated$summarystage <- tmp

curated$summarygrade <-  ifelse(uncurated$grade=="HG", "high", "low")

 
##N 
tmp <- tolower(uncurated$N)
tmp[tmp=="x"] <- NA
curated$N <- as.numeric(tmp)

##M
tmp <- tolower(uncurated$M)
tmp[tmp=="x"] <- NA
curated$M <- tmp

##age_at_initial_pathologic_diagnosis
curated$age <- as.numeric(uncurated$Age)

curated$gender = tolower(uncurated$Sex)

# 30 was probably what they used to calculate months
curated$days_to_death            =  round(uncurated$Survival..mos.*30) 
curated$vital_status             = ifelse(uncurated$Survival_Status == "DEAD", "deceased", "living")

tmp <- uncurated$Disease.status
tmp[tmp=="UNKNOWN"] <- NA
tmp[tmp=="FREE"] <- "norecurrence"
tmp[tmp=="NOT FREE"] <- "recurrence"
curated$recurrence_status <- tmp

curated <- postProcess(curated, uncurated)

write.table(curated, row.names=FALSE, file="../curated/GSE1827_curated_pdata.txt",sep="\t")



