test_counts <- function() {
    datapkg <- "curatedOvarianData"
    require(package=datapkg, character.only=TRUE)
    require(affy)
    strEsets <- data(package=datapkg)[[3]][,3]
    esets <- lapply(strEsets, function(x){
        data(list=x)
        get(x)
    })
    df <- data.frame(    
                     PMID=sapply(esets, pubMedIds), 
                     ncol=sapply(esets,ncol),
                     nrow=sapply(esets,nrow),
                     nwithbatch=sapply(esets, function(x) sum(!is.na(x$batch))),
                     deceased=sapply(esets,function(X)
                                     sum(X$vital_status=="deceased",na.rm=TRUE))
                     )
    df = df[order(df$PMID, df$ncol, df$nrow),]
    ## reference file was generated with the following commands on 0.3.0
    ##  write.csv(df, file="../extdata/counts.csv", quote=TRUE, row.names=FALSE)
    ## dfref <- read.csv("../extdata/counts.csv", as.is=TRUE)
    dfref <- read.csv(system.file("extdata/counts.csv", package = datapkg), as.is=TRUE)
    ##Do not check nrow for Normalizer or FULL version
    if(grepl("Normalizer|FULL", datapkg)){
        cols.to.check <- which(!grepl("nrow", colnames(df)))
    }else{
        ##but check all columns for regular version:
        cols.to.check <- 1:ncol(df)
    }
    sapply(cols.to.check, function(i) checkEquals(as.character(df[,i]), as.character(dfref[,i])))
}

