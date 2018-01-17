rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE8511_full_pdata.csv",as.is=TRUE,row.names=1)

#Note: Same issue w/ GleasonGrade--just the sum of the two measurements is curated
#even though the uncurated have includes some gleason grades for both measurements...
#searching the Internet suggested the total Gleason Grade number is what we care about...
##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##alt_sample_name
curated$alt_sample_name <- uncurated$title

##Read paper and see what their objectives are, see what tissues they used for the microarray
##specifically, did they sample the primary site or did they array the metastatic tumors
##ie did they take lymph nodes...metastasis in the lymph nodes

##sample_type
tmp <-tolower(uncurated$title)
tmp <- sub(".*(metastatic).*","\\1",tmp)
tmp <- sub(".*(benign).*","\\1",tmp)
tmp <- sub(".*(local).*","\\1",tmp)
tmp[tmp=="local"]<- "tumor"
tmp[tmp=="benign"]<- "adjacentnormal"  
curated$sample_type <- tmp

##gleasongrade
#tmp <- sub("[^.*Gleason sum:].*","\\1", uncurated$characteristics_ch2)
tmp <- uncurated$characteristics_ch2
tmp <- gsub("[^\\d+\\d]","",tmp,perl=TRUE)
tmp[tmp=="3+3"] <- "6"  
tmp[tmp=="4+3"] <- "7" 
tmp[tmp=="3+4"] <- "7"  
tmp[tmp=="4+4"] <- "8"    
tmp[tmp==""] <- NA
curated$gleasongrade <- tmp

##summarygrade
tmp <- uncurated$characteristics_ch2
tmp <- gsub("[^\\d+\\d]","",tmp,perl=TRUE)
tmp[(tmp=="4+3") | (tmp=="3+4")] <- "intermediate"
tmp[tmp=="3+3"] <- "low"  
tmp[tmp=="4+4"] <- "high"   
tmp[tmp==""] <- NA 
curated$summarygrade <- tmp

#M
tmp <-tolower(uncurated$title)
tmp <- sub(".*(metastatic).*","\\1",tmp)
tmp <- sub("metastatic","1",tmp,fixed=TRUE)
tmp[tmp !="1"] <- NA
curated$M <- tmp

#M_detail
tmp <- curated$M
tmp[tmp !="1"] <- NA
tmp[tmp =="1"] <- "c"
curated$M_detail <- tmp
  
#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE8511_curated_pdata.txt",sep="\t")
