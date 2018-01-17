rm(list=ls())
source("../../functions.R")
getVal <- function(x,string){
  output <- x[grep(string,x,fixed=TRUE)]
  if(length(output)==0) output <- NA
  return(output)
}

uncurated <- read.csv("../uncurated/GSE25326_full_pdata.csv", as.is=TRUE,row.names=1)
celfile.dir <- "../../../DATA/GSE25326/RAW"

##initial creation of curated dataframe

curated <- initialCuratedDF(rownames(uncurated), template.filename="template_lung.csv")

##--------------------
##start the mappings
##--------------------


curated$alt_sample_name <- uncurated$title

curated$primarysite <- "lung"

curated$sample_type - "tumor"

#histology
tmp <- uncurated$source_name_ch1
tmp[tmp=="NSCLC - adenocarcinoma"] <- "nsclc_adeno"
tmp[tmp=="NSCLC - squamous cell carcinoma"] <- "nsclc_squa"
tmp[tmp=="NSCLC - large cell carcinoma"] <- "nsclc_lcc"
curated$histology <- tmp

#gender
tmp <- uncurated$characteristics_ch1.2
tmp[tmp=="gender: male"] <- "m"
tmp[tmp=="gender: female"] <- "f"
curated$gender <- tmp

#smoker
tmp <- uncurated$characteristics_ch1.3
tmp[tmp=="smoking status: Ex"] <- "y"
tmp[tmp=="smoking status: Current"] <- "y"
tmp[tmp=="smoking status: Never"] <- "n"
tmp[tmp==""] <- NA
curated$smoker <- tmp

#kras_mutation
tmp <- apply(uncurated,1,getVal,string="kras mutation:")
tmp[tmp=="kras mutation: y"] <- "y"
tmp[tmp=="kras mutation: n"] <- "n"
curated$kras_mutation <- tmp

#p53_mutation
tmp <- apply(uncurated,1,getVal,string="p53 mutation:")
tmp[tmp=="p53 mutation: y"] <- "y"
tmp[tmp=="p53 mutation: n"] <- "n"
curated$p53_mutation <- tmp

#pik3ca_mutation
tmp <- apply(uncurated,1,getVal,string="pik3ca mutation:")
tmp[tmp=="pik3ca mutation: y"] <- "y"
tmp[tmp=="pik3ca mutation: n"] <- "n"
tmp[tmp=="pik3ca mutation: u"] <- NA
tmp[tmp=="pik3ca mutation: exon 20 A3140G"] <- NA
tmp[tmp=="pik3ca mutation: exon 9 A1634G"] <- NA
curated$pik3ca_mutation <- tmp


curated <- postProcess(curated)

write.table(curated, row.names = FALSE, file="../curated/GSE25326_curated_pdata.txt",sep="\t")
