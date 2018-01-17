rm(list=ls())
source("../../functions.R")
getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE2109_full_pdata.csv",as.is=TRUE,row.names=1)
uncurated <- uncurated[grep("ovary",uncurated$source_name_ch1,ignore.case=TRUE),]
uncurated <- uncurated[-grep("omentum",uncurated$source_name_ch1,ignore.case=TRUE),]

celfile.dir <- "../../../DATA/GSE2109/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

##--------------------
##start the mappings
##--------------------

##alt_sample_name
curated$alt_sample_name <- uncurated$title

##sample_type are all tumor
curated$sample_type <- "tumor"

##subtype
tmp <- apply(uncurated,1,getVal,string="Histology:")
tmp <- sub("Histology: ","",tmp,fixed=TRUE)
tmp[tmp=="Papillary Serous Adenocarcinoma"] <- "ser"
tmp[tmp=="Endometrioid adenocarcinoma"] <- "endo"
tmp[tmp=="Clear cell adenocarcinoma"] <- "clearcell"
tmp[tmp=="Endometrioid Carcinoma"] <- "endo"
tmp[tmp=="Mucinous Adenocarinoma"] <- "mucinous"
tmp[tmp=="Metastatic Endometrioid carcinoma"] <- "endo"
tmp[tmp=="Serous Adenocarinoma"] <- "ser"
tmp[tmp=="Papillary Serous Carcinoma"] <- "ser"
tmp[tmp=="Metastatic Papillary Serous Carcinoma"] <- "ser"
tmp[tmp=="Mucinous cystic tumor of low malignant potential"] <- "mucinous"
tmp[tmp=="Papillary serous tumor of low malignant potential"] <- "ser"
tmp[tmp=="Endometrioid Adenocarcinoma"] <- "endo"
tmp[tmp=="Metastatic Adenocarcinoma"] <- "adeno"
tmp[tmp=="Mucinous Carcinoma"] <- "mucinous"
tmp[tmp=="Adenocarcinoma"] <- "adeno"
tmp[tmp=="Undifferentiated carcinoma"] <- "undifferentiated"
tmp[tmp=="Adenocarcinoma, endometrioid and papillary serous"] <- "other"
tmp[tmp=="Dysgerminoma"] <- "other"
tmp[tmp=="Papillary serous cystadenocarcinoma"] <- "other"
tmp[tmp=="Metastatic Signet Ring Cell Carcinoma"] <- "other"
tmp[tmp=="Mixed epithelial tumor"] <- "other"
tmp[tmp=="Papillary mucinous cystadenocarcinoma"] <- "other"
tmp[tmp=="Signet ring cell carcinoma"] <- "other"
tmp[tmp=="Malignant teratoma"] <- "other"
tmp[tmp=="Adenocarcinoma with mixed subtypes"] <- "other"
tmp[tmp=="Adenocarcinoma with mixed subtypes"] <- "other"
tmp[tmp=="Metastatic Mucinous Carcinoma"] <- "other"
tmp[tmp=="Mixed endometrioid and papillary serous adenocarcinoma"] <- "other"
tmp[tmp=="Clear cell adenocarcinoma, NOS"] <- "other"
tmp[tmp==""] <- NA   #was "unknown"
tmp[tmp=="Malignant mixed muellerian tumor"] <- "other"
tmp[tmp=="Metastatic Malignant Neoplasm, NOS"] <- "other"
tmp[tmp=="Endometrioid adenocarcinoma, secretory variant"] <- "other"
tmp[tmp=="Benign serous cystadenoma of borderline malignancy"] <- "other"
tmp[tmp=="Diffuse large B-cell lymphoma"] <- "other"
tmp[tmp=="Metastatic Lobular Carcinoma"] <- "other"
tmp[tmp=="Transitional cell carcinoma"] <- "other"
tmp[tmp=="Carcinoma, NOS"] <- "other"
tmp[tmp=="Sertoli-Leydig cell tumor, poorly differentiated"] <- "other"
tmp[tmp=="Carcinosarcoma"] <- "other"
tmp[tmp=="Papillary cystadenocarcinoma"] <- "other"
tmp[tmp=="Benign serous cystadenoma of borderline malignancy"] <- "other"
tmp[tmp=="Metastatic Papillary Serous Adenocarcinoma"] <- "other"
tmp[tmp=="Mucinous cystadenocarcinoma"] <- "other"
tmp[tmp=="Papillary serous cystadenocarcinoma"] <- "other"
##tmp[tmp==NA] <- "unknown"
tmp[tmp=="NA"] <- NA   #was unknown
tmp[tmp=="adeno"] <- "other"
tmp[tmp=="Mixed Adenocarcinoma, Endometrioid and Clear Cell Types"] <- "other"
tmp[tmp=="Endometrioid adenocarcinoma with sguamous metaplasia"] <- "other"
tmp[tmp=="Metastatic Mucinous Adenocarcinoma"] <- "other"
tmp[tmp=="Adenosquamous carcinoma"] <- "other"
tmp[tmp=="Carcinoid tumor with atypical features"] <- "other"
curated$subtype <- tmp

##Primary.Site: primarysite
tmp <- apply(uncurated,1,getVal,string="Primary Site:")
tmp[tmp=="Primary Site: Ovary"] <- "ov"
tmp[tmp=="Primary Site: Colon"] <- "other"
tmp[tmp=="Primary Site: Gastrointestinal Tract, NOS"] <- "other"
tmp[tmp=="Primary Site: Exocrine pancreas"] <- "other"
tmp[tmp=="Primary Site: Stomach"] <- "other"
tmp[tmp=="Primary Site: Rectosigmoid"] <- "other"
tmp[tmp=="Primary Site: Unknown"] <- NA  #was "unknown"
tmp[tmp=="Primary Site: Endometrium"] <- "other"
tmp[tmp=="Primary Site: Small intestine"] <- "other"
tmp[tmp=="Primary Site: Breast"] <- "other"
tmp[tmp=="Primary Site: Peritoneum"] <- "other"
tmp[tmp=="Primary Site: Cervix Uteri"] <- "other"
tmp[tmp=="Primary Site: Ovary vs Peritoneum"] <- "other"
tmp[tmp=="Primary Site: Unknown Primary"] <- NA  #was "unknown"
tmp[tmp==""] <- "other"
curated$primarysite <- tmp

##Pathological T: -> T
tmp <- apply(uncurated,1,getVal,string="Pathological T:")
tmp <- sub("Pathological T: ","",tmp,fixed=TRUE)
tmp <- sub("[abc]","",tmp)
tmp[tmp=="X"] <- NA
curated$T <- tmp

##Pathological T: -> summarystage
tmp <- apply(uncurated,1,getVal,string="Pathological T:")
tmp <- sub("Pathological T: ","",tmp,fixed=TRUE)
tmp <- sub("[abc]","",tmp)
tmp[tmp=="X"] <-NA
tmp[tmp=="1"] <-"early"
tmp[tmp=="2"] <-"early"
tmp[tmp=="3"] <-"late"
tmp[tmp=="4"] <-"late"
curated$summarystage <- tmp

##Pathological T: -> substage
tmp <- apply(uncurated,1,getVal,string="Pathological T:")
tmp <- sub("Pathological T: ","",tmp,fixed=TRUE)
tmp <- sub("[0-9]","",tmp)
tmp[tmp==""] <- NA
tmp[tmp=="X"] <- NA
curated$substage <- tmp

##G
tmp <- apply(uncurated,1,getVal,string="Pathological Grade:")
tmp <- sub("Pathological Grade: ","",tmp,fixed=TRUE)
tmp[tmp=="X"] <- NA
curated$G <- tmp

##summarygrade
tmp <- apply(uncurated,1,getVal,string="Pathological Grade:")
tmp <- sub("Pathological Grade: ","",tmp,fixed=TRUE)
tmp[tmp=="X"] <- NA
tmp[tmp=="1"] <-"low"
tmp[tmp=="2"] <-"low"
tmp[tmp=="3"] <-"high"
tmp[tmp=="4"] <-"high"
curated$summarygrade <- tmp
 
##N 
tmp <- apply(uncurated,1,getVal,string="Pathological N:")
tmp <- sub("Pathological N: ","",tmp,fixed=TRUE)
tmp[tmp=="X"] <- NA
curated$N <- tmp

##M
tmp <- apply(uncurated,1,getVal,string="Pathological M:")
tmp <- sub("Pathological M: ","",tmp,fixed=TRUE)
tmp[tmp=="X"] <- NA
curated$M <- tmp

##age_at_initial_pathologic_diagnosis
tmp <- apply(uncurated,1,getVal,string="Patient Age:")
tmp <- sub("Patient Age: ","",tmp,fixed=TRUE)
tmp[tmp=="60-70"] <- "65"
tmp[tmp=="50-60"] <- "55"
tmp[tmp=="20-30"] <- "25"
tmp[tmp=="70-80"] <- "75"
tmp[tmp=="50-59"] <- "55"
tmp[tmp=="40-50"] <- "45"
tmp[tmp=="80-90"] <- "85"
tmp[tmp=="40-49"] <- "45"
tmp[tmp=="30-40"] <- "35"
tmp[tmp=="60-69"] <- "65"
curated$age_at_initial_pathologic_diagnosis <- tmp

##debulking, all unknown
curated$debulking <- NA   #was "unknown"


curated <- postProcess(curated)

write.table(curated, row.names=FALSE, file="../curated/GSE2109_curated_pdata.txt",sep="\t")



