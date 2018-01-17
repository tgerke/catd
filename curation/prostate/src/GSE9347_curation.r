rm(list=ls())
source("../../functions.R")

getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE9347_full_pdata.csv",as.is=TRUE,row.names=1)


##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type
curated$sample_type <- "tumor"

##gleasongrade
tmp <- apply(uncurated,1,getVal,string="Gleason_score:")
tmp <- sub(".*Gleason_score:*", "", tmp, perl=TRUE)
tmp[(tmp=="4+3") | (tmp=="3+4")] <- "7"
tmp[tmp=="3+3"] <- "6" 
tmp[tmp=="3+2"] <- "5"  
tmp[tmp=="2+4"] <- "6"  
tmp[tmp=="4+4"] <- "8"
tmp[tmp=="4+5"] <- "9" 
curated$gleasongrade <- tmp

##summarygrade
tmp <- apply(uncurated,1,getVal,string="Gleason_score:")
tmp <- sub(".*Gleason_score:*", "", tmp, perl=TRUE)
tmp[(tmp=="4+3") | (tmp=="3+4")] <- "intermediate"
tmp[tmp=="3+3"] <- "low" 
tmp[tmp=="3+2"] <- "low"  
tmp[tmp=="2+4"] <- "low"  
tmp[tmp=="4+4"] <- "high"
tmp[tmp=="4+5"] <- "high"    
curated$summarygrade <- tmp

curated$fusion. <- NA
curated$capsule. <- NA


#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE9347_curated_pdata.txt",sep="\t")
