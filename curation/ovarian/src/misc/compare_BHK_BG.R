library(plotrix)

bhk.dir <- "/shared/users/lwaldron/OVARIAN_BHK"
benganz.dir <- "../../curated"
map <- read.csv("Matching_BHK_to_curated.csv",as.is=TRUE)
map <- map[map$curated!="",]
rownames(map) <- NULL

for (i in 1:nrow(map)){
    ##if the file doesn't exist, go on to the next iteration of the loop:
    if( !file.exists(paste(bhk.dir,"/",map[i,"BHK"],"/",map[i,"BHK"],".RData",sep="")) ){
      print(paste("skipping ",map[i,"BHK"],sep=""))
      next
    }
    ##if it does exist, load it:
    load(paste(bhk.dir,"/",map[i,"BHK"],"/",map[i,"BHK"],".RData",sep=""))
    benhk <- demo
    benhk.columns <- c("age","e.os","t.os","e.rfs","t.rfs","hist.type","stage","grade","debulking.stage")
    ##fix inconsistent column names in benhk:
    if("t.dfs" %in% colnames(benhk)) benhk$t.rfs <- benhk$t.dfs
    if("e.dfs" %in% colnames(benhk)) benhk$e.rfs <- benhk$e.dfs
    ##add missing columns to benhk:
    for (chCol in benhk.columns){
      if( !chCol %in% colnames(benhk) )
        benhk[[chCol]] <- rep(NA,nrow(benhk))
    }
    benhk <- benhk[,c("age","e.os","t.os","e.rfs","t.rfs","hist.type","stage","grade","debulking.stage")]
    benganz <- read.delim(paste(benganz.dir,"/",map[i,"curated"],"_curated_pdata.txt",sep=""),as.is=TRUE)
    ##use alternative rownames for benganz for TCGA and Dressman:
    if(map[i,"BHK"]=="tcga2011"){
      rownames(benganz) <- benganz[,2]
    }else{      
      rownames(benganz) <- benganz[,1]
    }
    benganz <- benganz[,c("age_at_initial_pathologic_diagnosis","vital_status","days_to_death","recurrence_status","days_to_tumor_recurrence","subtype","T","G","debulking")]
    if(any(rownames(benhk) %in% rownames(benganz))){
      ##Keep only common rownames, and match the order, only if there is some overlap:
      benganz <- benganz[na.omit(rownames(benhk),rownames(benganz)),]
      benhk <- benhk[na.omit(rownames(benganz),rownames(benhk)),]
    }else{  ##add rows of NA to get the same length
      while(nrow(benganz) < nrow(benhk)){
        benganz <- rbind(benganz,rep(NA,ncol(benganz)))
      }
      while(nrow(benhk) < nrow(benganz)){
        benhk <- rbind(benhk,rep(NA,ncol(benhk)))
      }
    }
    ## ##convert to factors
    ## benhk$stage <- factor(benhk$stage)
    ## benhk$grade <- factor(benhk$grade)
    ## benhk$e.os <- factor(benhk$e.os)
    ## benhk$e.rfs <- factor(benhk$e.rfs)
    ## benhk$debulking.stage <- factor(benhk$debulking.stage)
    ## benhk$hist.type <- factor(benhk$hist.type)
    ## benganz$T <- factor(benganz$T)
    ## benganz$G <- factor(benganz$G)
    ## benganz$debulking <- factor(benganz$debulking)
    ##do the plotting
    pdf(paste("curationtest_",map[i,"BHK"],"_",map[i,"curated"],".pdf",sep=""),useDingbats=FALSE,width=10,height=10)
    par(mfrow=c(3,3))
    par(mar=c(5,4,4,2))  #narrower margins
    par(xpd=FALSE)  #don't clip anything to figure region
    for (j in 1:9){     
      plot(x=-5:5,y=-5:5,
           main=paste(map[i,1]," / ", map[i,2],"\n",colnames(benhk)[j]," / ",colnames(benganz)[j],sep=""),
           xaxt='n',yaxt='n',
           xlab="",ylab="",
           pch="")
      tmp <- cbind(benhk[,j],benganz[,j])
      colnames(tmp) <- c(colnames(benhk)[j],colnames(benganz)[j])
      addtable2plot(x=0,y=0,table=summary(tmp),xjust=0.5,yjust=0.5)
      legend("bottom",legend="Risch / Ganzfried",bty='n')      
    }
    if( !identical(all.equal(rownames(benhk),rownames(benganz)),TRUE)){
      dev.off()
      next
    }
    par(mfrow=c(3,3))
    par(mar=c(5,4,4,2))  #normal margins
    for (j in 1:9){
      if(class(benganz[,j])=="character" | class(benganz[,j])=="logical" | class(benganz[,j])=="logical" | all(is.na(benganz[,j])) | all(is.na(benhk[,j]))){
        plot(x=-5:5,y=-5:5,
             xaxt='n',yaxt='n',
             xlab="Ben Ganzfried",ylab="Markus Risch",
             main=paste(map[i,1]," / ", map[i,2],"\n",colnames(benhk)[j]," / ",colnames(benganz)[j],sep=""),
             pch="")
        if ( all(is.na(benganz[,j]) & is.na(benganz[,j])) ){
          legend(0,0,xjust=0.5,yjust=0.5,legend="all NA for both",bty='n')
        }else{
          try(addtable2plot(x=0,y=0,table=table(benhk[,j],benganz[,j],useNA="ifany"),display.rownames=TRUE,xjust=0.5,yjust=0.5 ,cex=1))
        }
      }else{
        plot(benhk[,j],benganz[,j],
             xlab="Markus Risch",ylab="Ben Ganzfried",
             main=paste(map[i,1]," / ", map[i,2],"\n",colnames(benhk)[j]," / ",colnames(benganz)[j],sep=""))
      }
    }
    dev.off()
##    system(paste("evince curationtest_",map[i,"BHK"],".pdf &",sep=""))        
    ## benhk$age[is.na(benhk$age)] <- -1      #make this a number so we can plot
    ## benhk$e.os[is.na(benhk$e.os)] <- -1
    ## benhk$t.os[is.na(benhk$t.os)] <- -1
    ## benhk$e.rfs[is.na(benhk$e.rfs)] <- -1
    ## benhk$t.rfs[is.na(benhk$t.rfs)] <- -1
    ## benganz$age_at_initial_pathologic_diagnosis[is.na(benganz$age_at_initial_pathologic_diagnosis)] <- -1      #make this a number so we can plot
    ## benganz$vital_status[is.na(benganz$vital_status)] <- -1
    ## benganz$days_to_death[is.na(benganz$days_to_death)] <- -1
    ## benganz$recurrence_status[is.na(benganz$recurrence_status)] <- -1
    ## benganz$days_to_tumor_recurrence[is.na(benganz$days_to_tumor_recurrence)] <- -1
  }
