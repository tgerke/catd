library(gdata)
rm(list=ls())

source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE26712_full_pdata.csv",as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE26712/RAW"

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")
##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
tmp <- sub("Ovarian Cancer, ","",tmp,fixed=TRUE)
tmp <- sub("Normal, ","",tmp,fixed=TRUE)
curated$alt_sample_name <- tmp

##primarysite all ov?
curated$primarysite <- "ov"

#subtype
tmp <- uncurated$characteristics_ch1
tmp <- sub("tissue: Late-stage high-grade ovarian cancer","ser",tmp,fixed=TRUE)
tmp <- sub("tissue: Normal ovarian surface epithelium",NA,tmp,fixed=TRUE)
curated$subtype <- tmp

##characteristics_ch1 -> sample_type
tmp <- uncurated$characteristics_ch1
tmp <- sub("tissue: Late-stage high-grade ovarian cancer","tumor",tmp,fixed=TRUE)
tmp <- sub("tissue: Normal ovarian surface epithelium","healthy",tmp,fixed=TRUE)
curated$sample_type <- tmp

##characteristics_ch1.3-> days_to_death
tmp <- uncurated$characteristics_ch1.3
tmp <- sub("survival years: ","",tmp,fixed=TRUE)
tmp <- as.numeric(tmp)
tmp <- tmp * 365  #years to days
curated$days_to_death <- tmp

##characteristics_ch1.1 -> debulking
tmp <- uncurated$characteristics_ch1.1
tmp <- sub("surgery outcome: ","",tmp,fixed=TRUE)
tmp[tmp=="Optimal"] <- "optimal"
tmp[tmp=="Suboptimal"] <- "suboptimal"
tmp[tmp==""] <- NA #was "unknown"
curated$debulking <- tmp

#characteristics_ch1.2 -> recurrence_status
tmp <- uncurated$characteristics_ch1.2
tmp[tmp=="status: NED (no evidence of disease)"] <- "norecurrence"
tmp[tmp=="status: DOD (dead of disease)"] <- "recurrence"
tmp[tmp=="status: AWD (alive with disease)"] <- "recurrence"
tmp[tmp==""] <- "norecurrence"
curated$recurrence_status <- tmp

##characteristics_ch1 -> T
tmp <- uncurated$characteristics_ch1
#tmp <- sub("tissue: Late-stage high-grade ovarian cancer","late",tmp,fixed=TRUE)
#IMPORTANT NOTE: "late" became "4" to pass regex check...
tmp[tmp=="tissue: Late-stage high-grade ovarian cancer"] <- "4"
tmp[tmp=="tissue: Normal ovarian surface epithelium"] <- "NA"
curated$T <- tmp

##summarystage
tmp <- uncurated$characteristics_ch1
tmp[tmp=="tissue: Late-stage high-grade ovarian cancer"] <- "late"
tmp[tmp=="tissue: Normal ovarian surface epithelium"] <- "NA"
curated$summarystage <- tmp

##characteristics_ch1 -> G
tmp <- uncurated$characteristics_ch1
#tmp <- sub("tissue: Late-stage high-grade ovarian cancer","high",tmp,fixed=TRUE)
#IMPORTANT NOTE: "high" became "4" to pass regex check...
tmp[tmp=="tissue: Late-stage high-grade ovarian cancer"] <- "4"
tmp[tmp=="tissue: Normal ovarian surface epithelium"] <- "NA"
curated$G <- tmp

##summarygrade
tmp <- uncurated$characteristics_ch1
tmp[tmp=="tissue: Late-stage high-grade ovarian cancer"] <- "high"
tmp[tmp=="tissue: Normal ovarian surface epithelium"] <- "NA"
curated$summarygrade <- tmp

##characteristics_ch1.2-> vital_status
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("status: ", "",tmp,fixed=TRUE)
#tmp <- sub("NED", "living",),sub("DOD", "deceased"), sub("", "living"), sub("AWD", "living"), 
tmp[tmp=="NED (no evidence of disease)"] <- "living"
tmp[tmp==""] <- "NA"
tmp[tmp=="DOD (dead of disease)"] <- "deceased"
tmp[tmp=="AWD (alive with disease)"] <- "living"
curated$vital_status <- tmp

# get age from the Excel Spreadsheet
db <- read.xls("../uncurated/DataBase_Bonome.xlsx",as.is=TRUE)
tmp  <- match(paste("SO",db[,1],sep=""),gsub("^.* SO",
    "SO",curated$alt_sample_name))
db <- db[!is.na(tmp),]
tmp <- tmp[!is.na(tmp)]
# do some sanity check (debulking status in spreadsheet same as in curation)    
test.debulking <- cbind(curated$debulking[tmp], db[,4])
stopifnot( all.equal(test.debulking[,1], tolower(test.debulking[,2])) )
curated$age_at_initial_pathologic_diagnosis[tmp] <- round(db[,9])


#tmp2 <- edit(curated) 

curated <- postProcess(curated)

write.table(curated, row.names=FALSE, file="../curated/GSE26712_curated_pdata.txt",sep="\t")
