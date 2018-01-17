rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/PMID17290060_clinical_info.csv",as.is=TRUE)#,row.names=1)
celfiles <- read.csv("../uncurated/PMID17290060_RAWfilenames.txt",as.is=TRUE,header=FALSE)
celfile.dir <- "../../../DATA/PMID17290060/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

##--------------------
##start the mappings
##--------------------
#alt_sample_name
#vital_status
#days_to_death
#T
#grade
#debulk
#primary_therapy_outcome_success
  #check the paper to make sure that NR/CR is response/no response
  #ask Gayatry if can't figure it out
  #NR: progressive disease
  #CR: Complete Response
#Ask: What is CA125 POST?

##OVC TumorID-> alt_sample_name
tmp <- uncurated$OVC.TumorID 
curated$alt_sample_name <- tmp

#WHY DIDN't THIS SHOW UP?
#0 = alive   1 = dead -> vital_status
tmp <- uncurated$X0...alive...1...dead
tmp[tmp=="0"] <- "living"
tmp[tmp=="1"] <- "deceased"
curated$vital_status <- tmp

#Survival -> days_to_death
tmp <- uncurated$Survival
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_death <- tmp

curated$sample_type <- "tumor"

#Assigned Stage ->T
tmp <- uncurated$Assigned.Stage
curated$T <- tmp

##summarystage
tmp <- uncurated$Assigned.Stage
tmp[tmp=="1"] <- "early"
tmp[tmp=="2"] <- "early"
tmp[tmp=="3"] <- "late"
tmp[tmp=="4"] <- "late"
curated$summarystage <- tmp  


#primarysite all "ov"?
curated$primarysite <- "ov"

#Grade -> grade
tmp <- uncurated$GRADE
tmp[tmp=="?"] <- NA
tmp[tmp==""] <- NA
tmp[tmp=="UNK"] <- NA
tmp[tmp==" 2/3"] <- "3"
tmp[tmp=="3    "] <- "3"
tmp[tmp=="2    "] <- "2"
tmp[tmp=="1    "] <- "1"   
curated$G <- tmp

##GRADE -> summarygrade
tmp <- uncurated$GRADE
tmp[tmp=="?"] <- NA
tmp[tmp==""] <- NA
tmp[tmp=="UNK"] <- NA
tmp[tmp==" 2/3"] <- "high"
tmp[tmp=="3    "] <- "high"
tmp[tmp=="2    "] <- "low"
tmp[tmp=="1    "] <- "low"
tmp[tmp=="1"] <-"low"
tmp[tmp=="2"] <-"low"
tmp[tmp=="3"] <-"high"
tmp[tmp=="4"] <-"high"   
curated$summarygrade <- tmp

##This abstract says that the training set which the authors used to
##create their model had 83 advanced-stage serous ovarian cancers. The
##paper does NOT explicitly say what the subtype of the remaining
##119-83=36 test set samples are, but it seems to imply all samples
##are serous:
curated$subtype <- "ser"


#Debulk -> debulking 
tmp <- uncurated$Debulk
tmp[tmp=="S"] <- "suboptimal"
tmp[tmp=="O"] <- "optimal" 
tmp[tmp=="Optimal"] <- "optimal"
tmp[tmp=="Suboptimal"] <- "suboptimal" 
tmp[tmp=="Suboptimal (10/3/97)"] <- "suboptimal" 
curated$debulking <- tmp

#response 0=NR, 1=CR -> primary_therapy_outcome_success
tmp <- uncurated$response.0.NR..1.CR
tmp[tmp=="0"] <- "progressivedisease"
tmp[tmp=="1"] <- "completeresponse"
curated$primary_therapy_outcome_success <- tmp 

#make a map of alt_sample_name to celfile name
celfiles$shortid <- sub("\\.cel","",sub("^.+h133a_","",celfiles[,1]))
curated$alt_sample_name[curated$alt_sample_name=="0.08"] <- ".08"  ##this looks like a typo in their clinical data
##get rid of sample 3249/3250, which doesn't match between celfiles and clinical data
curated <- curated[curated$alt_sample_name%in%celfiles$shortid,]
celfiles <- celfiles[celfiles$shortid%in%curated$alt_sample_name,]

##Define sample_names which match cel files:

celfiles <- celfiles[match(curated$alt_sample_name,celfiles$shortid),]
if(identical(all.equal(curated$alt_sample_name,celfiles$shortid),TRUE)){
  curated$sample_name <- sub("\\.cel","",celfiles[,1])
}

curated <- postProcess(curated)


curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/PMID17290060_curated_pdata.txt",sep="\t")
