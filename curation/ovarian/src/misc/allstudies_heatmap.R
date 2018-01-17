exprs.dir <- "/shared/users/lwaldron/OVARIAN_BG/AVERAGED"
benganz.dir <- "../../curated"

(studycodes <- dir(benganz.dir,pattern="txt$"))
(studycodes <- sub("_curated_pdata.txt","",studycodes))  ##get rid of _curated_pdata.txt)

has.survival <- rep(FALSE,length(studycodes))
names(has.survival) <- studycodes

all.data.list <- list()
for (i in 1:length(has.survival)){
  pdata <- read.delim(paste(benganz.dir,"/",studycodes[i],"_curated_pdata.txt",sep=""))
  if(any((!is.na(pdata$vital_status) & !is.na(pdata$days_to_death)) | !is.na(pdata$os_binary))){
    fileoption1 <- paste(exprs.dir,"/",studycodes[i],"_frma_curated_exprs_AVERAGED.txt",sep="")
    fileoption2 <- paste(exprs.dir,"/",studycodes[i],"_rma_curated_exprs_AVERAGED.txt",sep="")
    fileoption3 <- paste(exprs.dir,"/",studycodes[i],"_curated_exprs_AVERAGED.txt",sep="")
    if(file.exists(fileoption1)){
      print(paste("reading",fileoption1))
      all.data.list[[ studycodes[i] ]] <- read.delim(fileoption1,row.names=1,sep="\t")[-1,-1]
    }else if(file.exists(fileoption2)){
      print(paste("reading",fileoption2))
      all.data.list[[ studycodes[i] ]] <- read.delim(fileoption2,row.names=1,sep="\t")[-1,-1]
    }else if(file.exists(fileoption3)){
      print(paste("reading",fileoption3))
      tmp <- read.delim(fileoption3,sep="\t")
      rownames(tmp) <- make.names(tmp[,1])
      tmp <- tmp[-1,-1:-2]
      if(rownames(tmp)[1]=="X1"){  ##This just excludes GSE8842 for now, because the gene mapping failed.
        print(paste("Skipping",studycodes[i],"because of bad gene names."))
      }else{
        all.data.list[[ studycodes[i] ]] <- tmp
      }
    }
    all.data.list[[ studycodes[i] ]] <- all.data.list[[ studycodes[i] ]][,!grepl("ORF|ID",colnames(all.data.list[[ studycodes[i] ]]))]
  }
}

##colors for each study:
##library(colorspace)
##study.col.palette <- rainbow_hcl(n=length(all.data.list))
library(RColorBrewer)
study.col.palette <- brewer.pal(n=length(all.data.list),"Paired")
##study source for each sample:
study.names <- NULL
study.col <- NULL
for (i in 1:length(all.data.list)){
  study.names <- c(study.names,rep(names(all.data.list)[i],ncol(all.data.list[[i]])))
  study.col <- c(study.col,rep(study.col.palette[i],ncol(all.data.list[[i]])))
}
print(cbind(names(all.data.list),study.col.palette))

##accession ID translations:
translations <- read.delim("ovarian_datasets_translation.txt",as.is=TRUE)
translations <- translations[match(names(all.data.list),translations$accession),]
if(identical(all.equal(names(all.data.list),translations$accession),TRUE)){
  translations$study.col.palette <- study.col.palette
}

intersect.many <- function(lst){
  if (length(lst)==2){
    return(intersect(lst[[1]],lst[[2]]))
  }else{
    return(intersect.many(c(list(intersect(lst[[1]],lst[[2]])),lst[-1:-2])))
  }
}


rnames.lst <- lapply(all.data.list,rownames)
rnames.intersect <- intersect.many(rnames.lst)

all.data.intersect <- lapply(all.data.list,function(x) x[match(rnames.intersect,rownames(x)),])
all.data.intersect <- do.call(cbind,all.data.intersect)
dim(all.data.intersect)

all.data.cor <- cor(all.data.intersect,use="pairwise.complete.obs")


library(colorspace)
mybreaks <- seq(-1,1,by=0.01)
mycol <- diverge_hcl(length(mybreaks)-1)

myseq <- sample(1:ncol(all.data.cor),100,replace=FALSE)
myseq <- 1:ncol(all.data.cor)

dd <- as.dendrogram(hclust(dist(all.data.cor[myseq,myseq])))

png("ovarian_correlation_heatmap.png",width=7,height=7,units="in",res=150)
library(gplots)
heatmap.2(all.data.cor[myseq,myseq],
          col=mycol,
          breaks=mybreaks,
          ColSideColors=study.col[myseq],
          RowSideColors=study.col[myseq],
          Rowv=dd,
          Colv=dd,
          labRow=NA,
          labCol=NA,
          symm=TRUE,
          trace='none'
          )
dev.off()
system("evince ovarian_correlation_heatmap.png&")

png("legend.png",width=9,height=4,units="in",res=150)
plot(0:1,0:1,pch="",xaxt='n',yaxt='n',xlab="",ylab="",bty='n')
legend("center",
       legend=with(translations,paste(accession," - ",author.year," (",platform_summary,")",sep="")),
       lty=1,lw=4,
       col=translations$study.col.palette,
       cex=1,bty='n')
dev.off()
system("eog legend.png &")



## pal <- function(col, border = "light gray", ...)
## {
##   n <- length(col)
##   plot(0, 0, type="n", xlim = c(0, 1), ylim = c(0, 1),
##        axes = FALSE, xlab = "", ylab = "", ...)
##   rect(0:(n-1)/n, 0, 1:n/n, 1, col = col, border = border)
## }

## library(colorspace)
## pal(diverge_hcl(101))

## library(RColorBrewer)
## pal(brewer.pal(n=11,"Paired"))
