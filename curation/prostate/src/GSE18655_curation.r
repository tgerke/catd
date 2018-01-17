rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE18655_full_pdata.csv",as.is=TRUE,row.names=1)


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

#age_at_initial_pathologic_diagnosis
tmp <- uncurated$characteristics_ch1
tmp <- sub("age:", "", tmp, fixed = TRUE)
curated$age_at_initial_pathologic_diagnosis <- tmp

#psa_at_diagnosis
tmp <- uncurated$characteristics_ch1.1
tmp <- sub("psa: ", "", tmp, fixed = TRUE)
curated$psa_at_diagnosis <- tmp

#gleasongrade
tmp <- uncurated$characteristics_ch1.2
tmp <- as.numeric(gsub("[^\\d]","",tmp,perl=TRUE))
curated$gleasongrade <- tmp

#summarygrade
tmp <- curated$gleasongrade
tmp[tmp=="5"] <- "low"
tmp[tmp=="6"] <- "low"
tmp[tmp=="7"] <- "intermediate"
tmp[tmp=="8"] <- "high"
tmp[tmp=="9"] <- "high"
curated$summarygrade <- tmp

#recurrence_status
tmp <- uncurated$characteristics_ch1.3
tmp[tmp=="recurrence: No Rec"] <- "norecurrence"
tmp[tmp=="recurrence: Rec"] <- "recurrence"
curated$recurrence_status <- tmp

#days_to_death
tmp <- uncurated$characteristics_ch1.4
tmp <- sub("follow-up (months): ", "", tmp, fixed = TRUE)    
tmp <- as.numeric(tmp)
tmp <- tmp * 30  #months to days
curated$days_to_death <- tmp

#fusion
tmp <- uncurated$characteristics_ch1.5
tmp[tmp=="tmprss2: ERG Fusion: No Fusion"] <- "n"
tmp[tmp=="tmprss2: ERG Fusion: Fusion"] <- "y"
curated$fusion. <- tmp

#tumor_margins_positive
tmp <- uncurated$characteristics_ch1.6
tmp[tmp=="positive surgical margin: No Positive Margin"] <- "n"
tmp[tmp=="positive surgical margin: Positive Margin"] <- "y"
curated$tumor_margins_positive <- tmp

#extraprostatic_extension (y/n)
tmp <- ifelse(uncurated$characteristics_ch1.8=="pathologic stage category: extraprostatic","y","n")
curated$extraprostatic_extension <- tmp

#seminal_vesicle_invasion(y/n)
tmp <- ifelse(uncurated$characteristics_ch1.8=="pathologic stage category: seminal vesicle invasion","y","n")
curated$seminal_vesicle_invasion <- tmp


#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE18655_curated_pdata.txt",sep="\t")
