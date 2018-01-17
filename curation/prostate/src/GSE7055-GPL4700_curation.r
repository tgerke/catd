rm(list=ls())
source("../../functions.R")

uncurated <- read.csv("../uncurated/GSE7055-GPL4700_full_pdata.csv",as.is=TRUE,row.names=1)


##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type
curated$sample_type <-"tumor"

##race
tmp <- uncurated$characteristics_ch1
tmp <- sub(".+(Caucasian|African American).+","\\1",tmp)
#Tstg <- sub(".*T(\\d)N.", "\\1", tmp)
tmp[tmp=="Caucasian"] <- "caucasian"
tmp[tmp=="African American"] <- "black"
tmp[(tmp!="caucasian") & (tmp!="black")] <- NA
curated$race <- tmp

#smokingstatus
tmp <- uncurated$characteristics_ch1
tmp <- sub(".+(Smoking Status: Past|Smoking Status: Unknown|Smoking Status: Never|Smoking Status: Current| Smoking Status: NA).+","\\1",tmp)
tmp[tmp=="Smoking Status: Past"] <- "y"
tmp[tmp=="Smoking Status: Never"] <- "n"
tmp[tmp=="Smoking Status: Current"] <- "y"
tmp[(tmp!="y") & (tmp!="n")] <- NA
curated$smokingstatus <- tmp

##gleasongrade
tmp <- uncurated$characteristics_ch1
#tmp <- sub(".+(Gleason Sum: \\d).", "\\1", tmp)
tmp <- sub(".*Gleason Sum: (\\d),.*", "\\1", tmp)
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
curated$gleasongrade <- tmp

#summarygrade
#curated$summarygrade <- curate_summarygrade(curated$gleasongrade)
tmp <- curated$gleasongrade
tmp[tmp=="2"] <- "low"
tmp[tmp=="3"] <- "low"
tmp[tmp=="4"] <- "low"
tmp[tmp=="5"] <- "low"
tmp[tmp=="6"] <- "low"
tmp[tmp=="7"] <- "intermediate"
tmp[tmp=="8"] <- "high"
tmp[tmp=="9"] <- "high"
tmp[tmp=="10"] <- "high" 
curated$summarygrade <- tmp

#T
tmp <- uncurated$characteristics_ch1
tmp <- sub(".*PT Stage: (\\d),.*", "\\1", tmp)
tmp <- gsub("[^\\d]","",tmp,perl=TRUE)
curated$T <- tmp

#extraprostatic_extension
tmp <- uncurated$characteristics_ch1
tmp <- sub(".+(Extraprostatic Extension: None|Extraprostatic Extension: Focal|Extraprostatic Extension: Established|Extraprostatic Extension: Multifocal|Extraprostatic Extension: NA).+", "\\1", tmp)
tmp[tmp=="Extraprostatic Extension: None"] <- "n"
tmp[tmp=="Extraprostatic Extension: Focal"] <- "y"
tmp[tmp=="Extraprostatic Extension: Established"] <- "y"
tmp[tmp=="Extraprostatic Extension: Multifocal"] <- "y"
tmp[(tmp!="y") & (tmp!="n")] <- NA
curated$extraprostatic_extension <- tmp

#perineural_invasion
tmp <- uncurated$characteristics_ch1
tmp <- sub(".+(Perineural Invasion: Yes|Perineural Invasion: No|Perineural Invasion: NA).+", "\\1", tmp)
tmp[tmp=="Perineural Invasion: Yes"] <- "y"
tmp[tmp=="Perineural Invasion: No"] <- "n"
tmp[tmp=="Perineural Invasion: NA"] <- NA
tmp[tmp=="temp"] <- NA
curated$perineural_invasion <- tmp

#seminal_vesicle_invasion
tmp <- uncurated$characteristics_ch1
tmp <- sub(".+(Seminal vesicle invasion: Yes|Seminal vesicle invasion: No|Seminal vesicle invasion: NA).+", "\\1", tmp)
tmp[tmp=="Seminal vesicle invasion: Yes"] <- "y"
tmp[tmp=="Seminal vesicle invasion: No"] <- "n"
tmp[tmp=="Seminal vesicle invasion: NA"] <- NA
tmp[tmp=="temp"] <- NA
curated$seminal_vesicle_invasion <- tmp

#tumor_margins_positive
tmp <- uncurated$characteristics_ch1
tmp <- sub(".+(Are Surgical margins involved: All surgical margins are free of tumor|Are Surgical margins involved: Unknown|Are Surgical margins involved: Tumor widespread a surgical margins|Are Surgical margins involved: Tumor focal at margin|Are Surgical margins involved: Tumor widespread at margin).+", "\\1", tmp)
tmp[tmp=="Are Surgical margins involved: All surgical margins are free of tumor"] <- "n"
tmp[tmp=="Are Surgical margins involved: Tumor widespread a surgical margins"] <- "y"
tmp[tmp=="Are Surgical margins involved: Tumor focal at margin"] <- "y"
tmp[tmp=="Are Surgical margins involved: Tumor widespread at margin"] <- "y"
tmp[tmp=="Are Surgical margins involved: Unknown"] <- NA
tmp[tmp=="temp"] <- NA
curated$tumor_margins_positive <- tmp

#angiolymphatic_invasion
tmp <- uncurated$characteristics_ch1
tmp <- sub(".*Angio lymphatic invasion:(No|Yes|NA| No| Yes| NA).*", "\\1", tmp)
tmp[tmp=="Yes"] <- "y"
tmp[tmp=="No"] <- "n"
tmp[tmp=="NA"] <- NA
tmp[tmp==" Yes"] <- "y"
tmp[tmp==" No"] <- "n"
tmp[tmp==" NA"] <- NA
curated$angiolymphatic_invasion <- tmp


#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE7055-GPL4700_curated_pdata.txt",sep="\t")
