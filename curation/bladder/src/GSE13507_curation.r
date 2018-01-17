rm(list=ls())
source("../../functions.R")
getCol <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

getVal <-function(uncurated,string) {
    gsub(string, "", apply(uncurated,1,getCol,string=string))
}

uncurated <- read.csv("../uncurated/GSE13507_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE13507/RAW"

##initial creation of curated dataframe
curated <-
initialCuratedDF(rownames(uncurated),template.filename="template_bladder.csv")


##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp


##sample_type are all tumor
tmp = getVal(uncurated, "biological source: ")
tmp[ grep("normal", tmp) ]      = "healthy"
tmp[ grep("surrounding", tmp) ] = "adjacentnormal"
tmp[ grep("primary", tmp) ]     = "tumor"
tmp[ grep("recurrent", tmp) ]   = "metastatic"

curated$sample_type <- tmp

tmp <- getVal(uncurated,string="invasiveness: ")
tmp[tmp == "muscle invasive" ] = "invasive"
tmp[tmp == "non-muscle invasive" ] = "superficial"
curated$summarystage = tmp

tmp <- apply(uncurated,1,getCol,string="stage:")
curated$T = as.numeric(gsub("a","0",substr(tmp,8,8)))
curated$N = as.numeric(substr(tmp,10,10))
curated$M = ifelse(substr(tmp,10,10)=="1", 1, 0) 

curated$gender = tolower(getVal(uncurated, "SEX: "))
curated$age = as.numeric(getVal(uncurated, "AGE: "))

curated$days_to_death = round(as.numeric(getVal(uncurated, "survival month: ")) * 365.25/12)
curated$vital_status  = ifelse(getVal(uncurated, "overall survival: ")=="death", "deceased", "living")

tmp =  getVal(uncurated, "cancer specific survival: ")
tmp[curated$vital_status == "deceased" & tmp != "death"] = "doc"
tmp[curated$vital_status == "deceased" & tmp == "death"] = "dod"
tmp[curated$vital_status == "living" & tmp == "survival"] = "ned"
curated$dfs_event = tmp

curated$adjuvant_chemo = tolower(substr(getVal(uncurated, "systemic chemo: "),1,1))

curated <- postProcess(curated, uncurated)

write.table(curated, row.names = FALSE, file="../curated/GSE13507_curated_pdata.txt",sep="\t")
