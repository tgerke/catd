rm(list=ls())
source("../../functions.R")

rm(list=ls())
source("../../functions.R")
getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE14206_full_pdata.csv",as.is=TRUE,row.names=1)


##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type
tmp <- uncurated$source_name_ch1
tmp[tmp=="prostate cancer"] <- "tumor"
tmp[tmp=="normal prostate"] <- "healthy"
curated$sample_type <- "tumor"

##age_at_initial_pathologic_diagnosis
tmp <- apply(uncurated,1,getVal,string="age:")
tmp <- as.numeric(gsub("[^\\d\\d]","",tmp,perl=TRUE))
tmp <- round(tmp / 10)
curated$age_at_initial_pathologic_diagnosis <- tmp

#overall_stage_pathological
tmp <- apply(uncurated,1,getVal,string="stage: T")
tmp <- sub("stage: T", "", tmp, fixed = TRUE)
curated$overall_stage_pathological <- tolower(tmp)

#gleasongrade
tmp <- apply(uncurated,1,getVal,string="gleason grade")
tmp <- sub("gleason grade: ", "", tmp, fixed = TRUE)
tmp[tmp=="3-3"] <- "3+3"
tmp[tmp=="3-4"] <- "3+4"
tmp[tmp=="4-3"] <- "4+3"
tmp[tmp=="4-4"] <- "4+4"
tmp[tmp=="4-5"] <- "4+5"
tmp[tmp=="5-4"] <- "5+4"
curated$gleasongrade <- tmp

#summarygrade
tmp <- curated$gleasongrade
tmp[tmp=="3+3"] <- "low"
tmp[tmp=="3+4"] <- "intermediate"
tmp[tmp=="4+3"] <- "intermediate"
tmp[tmp=="4+4"] <- "high"
tmp[tmp=="4+5"] <- "high"
tmp[tmp=="5+4"] <- "high"
curated$summarygrade <- tmp

#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE14206_curated_pdata.txt",sep="\t")
