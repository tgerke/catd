rm(list=ls())
uncurated <- read.csv("../uncurated/GSE32062-GPL6480_full_pdata.csv",as.is=TRUE,row.names=1)
source("../../functions.R")

curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")

##sample_name
curated$alt_sample_name <- sub("serous ovarian cancer ", "", uncurated$title)


#sample_type
curated$sample_type <- "tumor"

#subtype
curated$subtype <- "ser"

#grade
tmp <- uncurated$characteristics_ch1.1
#remove "grading: " (or just take number...)
tmp <-  sub("grading: ","",tmp,perl=TRUE)
curated$G <- tmp

#summarygrade
#they say "high-grade" for all, but grades of 2 and 3, we did high grade as 3 or 4...
curated$summarygrade[curated$G == "2"] <- "low"
curated$summarygrade[curated$G == "3"] <- "high"

#summarystage
curated$summarystage <- "late"

#T
tmp <- uncurated$characteristics_ch1.2
tmp <- gsub("[^IV]","",tmp,perl=TRUE)
tmp[tmp == "III"] <- "3"
tmp[tmp == "IV"] <- "4"
curated$T <- tmp

#substage
tmp <- uncurated$characteristics_ch1.2
tmp <- sub("Stage: IV","",tmp,fixed=TRUE)
tmp <- sub("Stage: III","",tmp,fixed=TRUE)
tmp[tmp==""] <- NA
curated$substage <- tmp

#debulking
tmp <- uncurated$characteristics_ch1.3
tmp <- sub("surgery status: ","",tmp,fixed=TRUE)
tmp <- tolower(tmp)
curated$debulking <- tmp

#tax
#1=yes, ie all patients were treated with taxane.
tmp <- uncurated$characteristics_ch1.4
tmp[tmp=="taxane: 1"] <- 'y'
curated$tax <- tmp

#pltx
## 1=yes, ie all patients were treated with platinum
tmp <- uncurated$characteristics_ch1.5
tmp[tmp=="platinum: 1"] <- 'y'
curated$pltx <- tmp

## ##pfs (progression-free survival) is not part of the template
## tmp <- uncurated$characteristics_ch1.6
## tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
## tmp <- as.numeric(tmp)
## curated$days_to_tumor_recurrence <- tmp*30
## #pfs_status
## tmp <- uncurated$characteristics_ch1.7
## tmp[tmp=="rec (1): 1"] <- 'y'
## tmp[tmp=="rec (1): 0"] <- 'n'
## curated$recurrence_status <- tmp

#days_to_death
#just take number
tmp <- uncurated$characteristics_ch1.8
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
tmp <- as.numeric(tmp)
curated$days_to_death <- tmp*30

#vital_status
#remove death (1):
tmp <- uncurated$characteristics_ch1.9
tmp[tmp=="death (1): 1"] <- 'deceased'
tmp[tmp=="death (1): 0"] <- 'living'
curated$vital_status <- tmp

curated <- postProcess(curated)

for (i in 1:ncol(curated)){
    if (!all(is.na(curated[[i]])) & length(unique(curated[[i]])) < length(curated[[i]])){
        cat(colnames(curated)[i])
        if(class(curated[[i]]) == "numeric" || class(curated[[i]]) == "integer"){
            print(summary(curated[[i]]))
        }else if(class(curated[[i]]) == "character" || class(curated[[i]]) == "factor" || class(curated[[i]]) == "logical"){
            print(table(curated[[i]]))
        }
        cat("\n")
    }
}

    
write.table(curated, row.names = FALSE, file="../curated/GSE32062-GPL6480_curated_pdata.txt",sep="\t")
