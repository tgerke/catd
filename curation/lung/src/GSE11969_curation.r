rm(list=ls())
source("../../functions.R")
getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE11969_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE11969/RAW"

##initial creation of curated dataframe

curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#sample_type(tumor)
#primarysite (lung)
#age
#gender
#histology
#T (AGAIN, T NOT = stage.  what to do?)
#N (DO LATER!!)
#M (DO LATER!!)
#substage (figure out T vs stage first)
#vital_status (living|deceased)
#days_to_death
#recurrence_status
#egfr_status (wt|mut)
#gefitinib_treatment (y|n)
#summarygrade (moderately, poorly, well)
#kras_mutation (y = mutation; n = wildtype)
#p53_mutation

#alt_sample_name
curated$alt_sample_name <- uncurated$title

#sample_type(tumor)
tmp <- uncurated$source_name_ch1
tmp[tmp=="Primary lung tumor"] <- "tumor"
tmp[tmp=="Normal lung tissue"] <- "healthy"
curated$sample_type <- tmp

#primarysite (lung)
curated$primarysite <- "lung"

#age
tmp <- uncurated$characteristics_ch1.2
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp[tmp==""] <- NA
curated$age_at_initial_pathologic_diagnosis <- tmp


#gender
tmp <- uncurated$characteristics_ch1.3
tmp[tmp=="Sex: M"] <- "m"
tmp[tmp=="Sex: F"] <- "f"
tmp[tmp==""] <- NA
curated$gender <- tmp

#histology
tmp <- uncurated$characteristics_ch1.4
tmp <- gsub("Histology: ","",tmp,perl=TRUE)
tmp <- tolower(tmp)
tmp[tmp=="normal lung tissue"] <- "normal"
curated$histology <- tmp

#vital_status (living|deceased)
tmp <- uncurated$characteristics_ch1.8
tmp[tmp=="Status: Dead"] <- "deceased"
tmp[tmp=="Status: Alive"] <- "living"
tmp[tmp=="Status: NA"] <- NA
curated$vital_status <- tmp

#days_to_death
tmp <- uncurated$characteristics_ch1.9
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp[tmp==""] <- NA
curated$days_to_death <- tmp

#recurrence_status
tmp <- uncurated$characteristics_ch1.10
tmp[tmp=="Evidence of relapse: N"] <- "norecurrence"
tmp[tmp=="Evidence of relapse: Y"] <- "recurrence"
tmp[tmp=="Evidence of relapse: NA"] <- NA
tmp[tmp=="Evidence of relapse: Unknown"] <- NA
curated$recurrence_status <- tmp


#egfr_status (wt|mut)
tmp <- uncurated$characteristics_ch1.12
tmp[tmp=="EGFR status: Mut"] <- "mut"
tmp[tmp=="EGFR status: Wt"] <- "wt"
tmp[tmp=="EGFR status: NA"] <- NA
curated$egfr_status <- tmp


#gefitinib_treatment (y|n)
tmp <- uncurated$characteristics_ch1.15
tmp[tmp=="Gefitinib treatment:"] <- NA
tmp[tmp=="Gefitinib treatment: Y"] <- "y"
tmp[tmp=="Gefitinib treatment: NA"] <- NA
curated$gefitinib_treatment <- tmp

#summarygrade (moderately, poorly, well)
tmp <- uncurated$characteristics_ch1.20
tmp[tmp=="Grade: Poorly"] <- "poorly"
tmp[tmp=="Grade: Moderately"] <- "moderately"
tmp[tmp=="Grade: Well"] <- "well"
tmp[tmp=="Grade: NA"] <- NA
tmp[tmp=="Grade:"] <- NA
curated$summarygrade <- tmp


#kras_mutation (y = mutation; n = wildtype)
tmp <- uncurated$characteristics_ch1.13
tmp[tmp=="K-ras Status: Mut"] <- "y"
tmp[tmp=="K-ras Status: Wt"] <- "n"
tmp[tmp=="K-ras Status: NA"] <- NA
curated$kras_mutation <- tmp

#p53_mutation
tmp <- uncurated$characteristics_ch1.14
tmp[tmp=="p53 Status: Mut"] <- "y"
tmp[tmp=="p53 Status: Wt"] <- "n"
tmp[tmp=="p53 Status: NA"] <- NA
curated$p53_mutation <- tmp


curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE11969_curated_pdata.txt",sep="\t")
