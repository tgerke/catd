ids <- read.delim("inputIdentifiers.txt",as.is=TRUE,header=FALSE)[,1]

srcoutput <- sapply(ids,function(thisid) paste("=hyperlink(*http://cen1.dfci.harvard.edu/repos/curation/ovarian/src/",thisid,"_curation.r*;*src*)",sep=""))
curatedoutput <- sapply(ids,function(thisid) paste("=hyperlink(*http://cen1.dfci.harvard.edu/repos/curation/ovarian/curated/",thisid,"_curated_pdata.txt*;*curated*)",sep=""))
uncuratedoutput <- sapply(ids,function(thisid) paste("=hyperlink(*http://cen1.dfci.harvard.edu/repos/curation/ovarian/uncurated/",thisid,"_full_pdata.csv*;*uncurated*)",sep=""))

output <- cbind(curatedoutput,uncuratedoutput,srcoutput)

for (i in colnames(output)){
  write.table(output[,i],paste("output_",i,".txt",sep=""),quote=FALSE,row.names=FALSE,col.names=FALSE)
}

##sed -i -e 's/*/"/g' output*.txt
