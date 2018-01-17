rm(list=ls())

source("../../functions.R")
##TCGA has both original and follow-up clinical data.  This is
##unusually complicated because an additional form ID was added to the
##follow-up patient IDs, original form data are repeated in the
##follow-up dataset, but some patients are missing int he follow-up
##dataset, some information is missing in the original (like
##days_to_recurrence), and other information is missing in the
##follow-up (like histology).  The approach taken here will be to take
##data from the follow-up where available and from the original
##otherwise, and include a patient even if they are present only in
##the original.
original <- read.delim("../uncurated/clinical_patient_public_ov.txt",as.is=TRUE,row.names=1,na.strings=c("[Not Available]", "[Not Applicable]", "[Pending]"))

##follow-up data:
follow.up <- read.delim("../uncurated/clinical_follow_up_v1.0_public_ov.txt",as.is=TRUE,row.names=1,na.strings=c("[Not Available]", "[Not Applicable]", "[Pending]"))

##Some patients have more than one form (ie when there is an update to
##the clinical information).  Split the follow.up dataframe per-patient:
patient.IDs <- sapply( strsplit(rownames(follow.up), split="-"), function(x) paste(x[1:3], collapse="-") )
##Split the follow.up dataframe into a list, one element per unique patient ID:
follow.up.list <- lapply( unique(patient.IDs), function(id)
                         follow.up[grep(id, rownames(follow.up)), ] )
##order each list element by year, month, day of form completion, then
##keep the first element.  The first element will either be the only
##element, or the one occuring at the *latest* date:
follow.up.list <- lapply(follow.up.list, function(x){
    x[order(x$year_of_form_completion,
            x$month_of_form_completion,
            x$day_of_form_completion,
            decreasing=TRUE)[1], ]
})
##Now rbind back to a single dataframe, which contains only the most recent follow-up:
follow.up <- do.call(rbind, follow.up.list)

##Get rid of what comes after the third "-" to change rownames to patient IDs:
rownames(follow.up) <- sapply( strsplit(rownames(follow.up), split="-"), function(x) paste(x[1:3], collapse="-") )

##Now we need to merge the original and the follow-up dataframes.
##First, get rid of columns in the original dataframe which are also
##present in the follow-up dataframe:
original <- original[, !colnames(original) %in% colnames(follow.up)]

##Some patients were present in the original, but not in
##the follow.up.  Add rows of NA to these patients in the follow-up:
missing.in.followup <- rownames(original)[!rownames(original) %in% rownames(follow.up)]
blank.df <- data.frame(matrix(NA, nrow=length(missing.in.followup), ncol=ncol(follow.up)))
rownames(blank.df) <- missing.in.followup
colnames(blank.df) <- colnames(follow.up)
##Then merge these blank rows with the original:
follow.up <- rbind(follow.up, blank.df)

##Finally merge the original and follow-up clinical data:
if( all(rownames(follow.up) %in% rownames(original)) & all(rownames(original) %in% rownames(follow.up)) )
    follow.up <- follow.up[match(rownames(original), rownames(follow.up)), ]
if( identical(rownames(original), rownames(follow.up)) )
    uncurated <- cbind(original, follow.up)
celfile.dir <- "../../../DATA/TCGA/RAW"

##map between cel files and patient barcodes
celfiles.map <- read.delim("../uncurated/broad.mit.edu_OV.HT_HG-U133A.sdrf.txt",as.is=TRUE)
celfiles.map <- celfiles.map[,match(c("Extract.Name","Array.Data.File"),colnames(celfiles.map))]
celfiles.map$alt_sample_name <- sub("-[0-9]{2}[A-Z]-[0-9]{2}[A-Z]-[0-9]{4}-[0-9]{2}","",celfiles.map[,1])

##batch information
batch.info <- readLines("../uncurated/TCGA_file_sources.txt")
batch.info <- do.call(rbind,strsplit(batch.info,split="/"))
batch.info <- batch.info[,-1]
batch.info[,1] <- sub("^.+Level_1\\.","",batch.info[,1])
batch.info[,1] <- sub("\\.1004\\.0","",batch.info[,1])
batch.info <- data.frame(batch.info,stringsAsFactors=FALSE)
colnames(batch.info) <- c("batch","Array.Data.File")
batch.info <- batch.info[match(celfiles.map$Array.Data.File,batch.info$Array.Data.File),]

if(identical(all.equal(celfiles.map$Array.Data.File,batch.info$Array.Data.File),TRUE))
  {
    print("Adding batch info to celfiles.map")
    celfiles.map$batch <- batch.info$batch
  }

summary(rownames(uncurated) %in% celfiles.map$alt_sample_name)  #26 FALSE, 572 TRUE
summary(celfiles.map$alt_sample_name %in% rownames(uncurated))  #8 FALSE, 589 TRUE

##Keep only samples for which we have a mapping to the celfile - lose 26 samples
keep.ids <- intersect(celfiles.map$alt_sample_name,rownames(uncurated))
uncurated <- uncurated[match(keep.ids,rownames(uncurated)),]

##create a new uncurated dataframe which contains duplicate rows for the technical replicates
uncurated.withreps <- matrix(NA,nrow=nrow(celfiles.map),ncol=ncol(uncurated))
rownames(uncurated.withreps) <- sub(".CEL","",celfiles.map$Array.Data.File,fixed=TRUE)
colnames(uncurated.withreps) <- colnames(uncurated)
uncurated.withreps <- data.frame(uncurated.withreps)
uncurated.withreps$unique_patient_ID <- celfiles.map$alt_sample_name
uncurated.withreps$batch <- celfiles.map$batch
uncurated.withreps$Extract.Name <- celfiles.map$Extract.Name
for (i in 1:nrow(uncurated.withreps))
  {
    uncurated.withreps[i,1:ncol(uncurated)] <- uncurated[match(uncurated.withreps$unique_patient_ID[i],rownames(uncurated)),]
  }
uncurated <- uncurated.withreps;rm(uncurated.withreps)


##Keep primary tumors and normal tissues only.
tumor.num <- strsplit(uncurated$Extract.Name,split="-")
tumor.num <- sapply(tumor.num,function(x) x[4])
tumor.num <- sub("[A-Z]","",tumor.num)
##This excludes some type 02 - "Recurrent Solid Tumor" and 11 - "Solid
##Tissue Normal".  Type 01 is "Primary Solid Tumor".
keep.samples <- tumor.num=="01" | tumor.num=="11"  ##keep 01 - "Recurrent Solid Tumor" and 11 - "Solid Tissue Normal".
uncurated <- uncurated[keep.samples,]
tumor.num <- tumor.num[keep.samples]

##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="template_ov.csv")
curated$unique_patient_ID <- uncurated$unique_patient_ID
curated$batch <- uncurated$batch
curated$alt_sample_name <- uncurated$Extract.Name  ##Put Extract.Name for alt_sample_name

##--------------------
##start the curation
##--------------------

##01 - "Recurrent Solid Tumor" and 11 - "Solid Tissue Normal".
##histological_type -> sample_type
tmp <- tumor.num
tmp <- sub("01","tumor",tmp,fixed=TRUE)
tmp <- sub("11","adjacentnormal",tmp,fixed=TRUE)
curated$sample_type <- tmp

##histological_type -> subtype
tmp <- uncurated$histological_type
tmp[tmp=="Serous Cystadenocarcinoma"] <- "ser"
tmp[is.na(tmp)] <- NA   #was "unknown"
curated$subtype <- tmp

##primary_site -> tumor_tissue_site
tmp <- uncurated$tumor_tissue_site 
tmp[tmp=="OVARY"] <- "ov"
tmp[!tmp=="ov"] <- "other"  #omentum and peritoneum -> "other"
curated$primarysite <- tmp

##T -> tumor_stage
tmp <- uncurated$tumor_stage
tmp <- gsub("[^IV]","",tmp)
tmp[tmp==""] <- NA
tmp[tmp=="I"] <- "1"
tmp[tmp=="II"] <- "2"
tmp[tmp=="III"] <- "3"
tmp[tmp=="IV"] <- "4"
tmp <- as.integer(tmp)
curated$T <- tmp

##summarystage
tmp <- uncurated$tumor_stage
tmp <- gsub("[^IV]","",tmp)
tmp[tmp==""] <- NA
tmp[tmp=="I"] <- "early"
tmp[tmp=="II"] <- "early"
tmp[tmp=="III"] <- "late"
tmp[tmp=="IV"] <- "late"
curated$summarystage <- tmp

##substage
tmp <- uncurated$tumor_stage
tmp <- gsub("[^ABC]","",tmp)
tmp[tmp==""] <- NA
tmp[tmp=="A"] <- "c"
tmp[tmp=="B"] <- "b"
tmp[tmp=="C"] <- "c"
curated$substage <- tmp

##tumor_grade -> G
tmp <- uncurated$neoplasm_histologic_grade
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
##Don't know what GB or GX are, set these to NA:
tmp[tmp=="GX"] <- NA
tmp[tmp=="GB"] <- NA
tmp <- as.integer(tmp)
curated$G <- tmp

##summarygrade
tmp <- curated$G
tmp[tmp==1] <-"low"
tmp[tmp==2] <-"low"
tmp[tmp==3] <-"high"
tmp[tmp==4] <-"high"
curated$summarygrade <- tmp

##age_at_initial_pathologic_diagnosis
tmp <- uncurated$age_at_initial_pathologic_diagnosis
tmp[tmp=="null"] <- NA
tmp <- as.integer(tmp)
curated$age_at_initial_pathologic_diagnosis <- tmp


##site_of_tumor_first_recurrence
tmp <- uncurated$site_of_tumor_first_recurrence
tmp[tmp=="Metastasis"] <-"metastasis"
tmp[tmp=="Loco-Regional"] <- "locoregional"
tmp[tmp=="Locoregional and Metastasis"] <- "locoregional_plus_metastatic"
curated$site_of_tumor_first_recurrence <- tmp

##daystotumorrecurrence
daystotumorrecurrence <- uncurated$days_to_tumor_recurrence
daystolastfollowup <- uncurated$days_to_last_followup
tmp <- daystotumorrecurrence
tmp[is.na(curated$site_of_tumor_first_recurrence)] <- daystolastfollowup[is.na(curated$site_of_tumor_first_recurrence)]
curated$days_to_tumor_recurrence <- tmp

##recurrence_status.
curated$recurrence_status <- ifelse(is.na(curated$site_of_tumor_first_recurrence), "norecurrence", "recurrence")

##daystodeath
daystodeath <- uncurated$days_to_death  
daystolastfollowup <- uncurated$days_to_last_followup
vitalstatus <- uncurated$vital_status
vitalstatus[is.na(vitalstatus)] <- NA   #was "unknown"
tmp <- daystodeath
tmp[grep("LIVING", vitalstatus)] <- daystolastfollowup[grep("LIVING", vitalstatus)]
##If vital status is unknown, set days_to_death to NA as well.
tmp[ is.na(vitalstatus) ] <- NA
curated$days_to_death<- tmp

##vital_status
tmp <- tolower(uncurated$vital_status)
curated$vital_status <- tmp

##primary_therapy_outcome_success
tmp <- uncurated$primary_therapy_outcome_success
tmp[tmp=="Complete Response"] <- "completeresponse"
tmp[tmp=="Progressive Disease"] <- "progressivedisease"
tmp[tmp=="Partial Response"] <- "partialresponse"
tmp[tmp=="Stable Disease"] <- "stabledisease"
curated$primary_therapy_outcome_success <- tmp


##debulking
tmp <- uncurated$tumor_residual_disease
tmp[tmp=="No Macroscopic disease"] <- "optimal"
tmp[tmp=="1-10 mm"] <- "suboptimal"
tmp[tmp==">20 mm"] <- "suboptimal"
tmp[tmp=="11-20 mm"] <- "suboptimal"
tmp[tmp==""] <- NA
curated$debulking <- tmp

##Note that TCGA celfiles do not contain a run date for some reason,
##so the celfile_run_date column will just contain NA:
curated <- postProcess(curated)
curated$batch <- uncurated$batch

write.table(curated, row.names=FALSE, file="../curated/TCGA_curated_pdata.txt",sep="\t")
