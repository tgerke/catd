CURATED <- "../../curated"
cwd <- getwd()
setwd(CURATED)
allfiles <- dir(pattern="*.txt")

allstudies <- lapply(allfiles,function(thisfile){
  x <- read.delim(thisfile,as.is=TRUE)
  x$study <- sub("_curated_pdata.txt","",thisfile)
  return(x)
})

names(allstudies) <- allfiles

sort(sapply(allstudies,ncol))

allstudies <- do.call(rbind,allstudies)

inferred.refrac <- allstudies$inferred_chemo_response=="refractory" & !is.na(allstudies$inferred_chemo_response)
primary.success <- allstudies$primary_therapy_outcome_success=="progressivedisease" & !is.na(allstudies$primary_therapy_outcome_success)
chemo.response <- !is.na(allstudies$chemo_response)

possible.refrac <- inferred.refrac | primary.success | chemo.response

refractorystudies <- allstudies[possible.refrac,]


write.csv(allstudies,"ovarian.studies.summary.csv")
write.csv(refractorystudies,"possible.refractory.summary.csv")
