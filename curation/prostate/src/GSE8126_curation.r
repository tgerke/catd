rm(list=ls())
source("../../functions.R")

getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE8126_full_pdata.csv",as.is=TRUE,row.names=1)


##initial creation of curated dataframe
curated <- initialCuratedDF(rownames(uncurated),template.filename="Prostate_Draft_Template_June_1_2011.csv")

##--------------------
##start the mappings
##--------------------

##title -> alt_sample_name
tmp <- uncurated$title
curated$alt_sample_name <- tmp

##sample_type
tmp <- uncurated$title
tmp <- sub(".*(tumor).*", "\\1", tmp)
tmp <- sub(".*(normal).*", "\\1", tmp)
tmp[tmp=="normal"] <- "adjacentnormal"
curated$sample_type <-tmp

#race
tmp <- tolower(uncurated$characteristics_ch1)
tmp <- sub(".*(caucasian).*", "\\1", tmp)
tmp <- sub(".*(african american).*", "\\1", tmp)
tmp[tmp=="african american"] <- "black"
curated$race <-tmp

##smokingstatus
tmp <- apply(uncurated,1,getVal,string="smoking status:")
tmp <- sub("smoking status: ","",tmp,fixed=TRUE)
tmp[tmp=="Past"] <- "y"
tmp[tmp=="Current"] <- "y"
tmp[tmp=="Never"] <- "n"
tmp[tmp=="Unknown"] <- "n"
tmp[tmp=="NA"] <- NA
curated$smokingstatus <- tmp

#gleasongrade
tmp <- apply(uncurated,1,getVal,string="gleason sum:")
curated$gleasongrade <- sub("gleason sum: ","",tmp,fixed=TRUE)

#summarygrade
tmp <- curated$gleasongrade
tmp[tmp=="4"] <- "low"
tmp[tmp=="5"] <- "low"
tmp[tmp=="6"] <- "low"
tmp[tmp=="7"] <- "intermediate"
tmp[tmp=="8"] <- "high"
curated$summarygrade <- tmp

#T
tmp <- apply(uncurated,1,getVal,string="pt stage:")
curated$T <- sub("pt stage: ","",tmp,fixed=TRUE)

#extraprostatic_extension
tmp <- apply(uncurated,1,getVal,string="extraprostatic extension:")
#tmp[(tmp=="extraprostatic extension: NA") ] <- ""
tmp[(tmp=="extraprostatic extension: None")]<- "n"
tmp[(tmp=="extraprostatic extension: NA")]<- NA
tmp[(tmp!="n") & !is.na(tmp)] <- "y"
curated$extraprostatic_extension <- tmp

#perineural_invasion
tmp <- apply(uncurated,1,getVal,string="perineural invasion:")
tmp[(tmp=="perineural invasion: No")]<- "n"
tmp[(tmp=="perineural invasion: NA")]<- NA
tmp[(tmp=="perineural invasion: Yes")]<- "y"
curated$perineural_invasion <- tmp

#seminal_vesicle_invasion
tmp <- apply(uncurated,1,getVal,string="seminal vesicle invasion:")
tmp[(tmp=="seminal vesicle invasion: No")]<- "n"
tmp[(tmp=="seminal vesicle invasion: NA")]<- NA
tmp[(tmp=="seminal vesicle invasion: Yes")]<- "y"
tmp[(tmp=="seminal vesicle invasion: Yes Are Surgical margins involved: All surgical margins are free of tumor")]<- "y"
curated$seminal_vesicle_invasion <- tmp

#tumor_margins_positive
tmp <- apply(uncurated,1,getVal,string="are surgical margins involved:")
tmp <- sub(".+(Are Surgical margins involved: All surgical margins are free of tumor|Are Surgical margins involved: Unknown|Are Surgical margins involved: Tumor widespread a surgical margins|Are Surgical margins involved: Tumor focal at margin|Are Surgical margins involved: Tumor widespread at margin).+", "\\1", tmp)
tmp[tmp=="are surgical margins involved: All surgical margins are free of tumor"] <- "n"
tmp[tmp=="are surgical margins involved: Tumor widespread a surgical margins"] <- "y"
tmp[tmp=="are surgical margins involved: Tumor focal at margin"] <- "y"
tmp[tmp=="are surgical margins involved: Tumor widespread at margin"] <- "y"
tmp[tmp=="are surgical margins involved: Unknown"] <- NA
tmp[tmp=="are surgical margins involved: NA"] <- NA
curated$tumor_margins_positive <- tmp

#angiolymphatic_invasion
tmp <- apply(uncurated,1,getVal,string="angio lymphatic invasion:")
tmp <- sub(".*angio lymphatic invasion:(No|Yes|NA| No| Yes| NA).*", "\\1", tmp)
tmp[tmp=="Yes"] <- "y"
tmp[tmp=="No"] <- "n"
tmp[tmp=="NA"] <- NA
tmp[tmp==" Yes"] <- "y"
tmp[tmp==" No"] <- "n"
tmp[tmp==" NA"] <- NA
curated$angiolymphatic_invasion <- tmp

#tmp2 <- edit(curated) 
write.table(curated, row.names=FALSE, file="../curated/GSE8126_curated_pdata.txt",sep="\t")
