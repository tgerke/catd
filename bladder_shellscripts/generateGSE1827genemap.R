map =
read.csv("../curation/bladder/uncurated/GSE1827_symbol_clone_mapping.csv",
stringsAsFactors=FALSE)
x  = read.csv("../DATA/GSE1827/PROCESSED/DEFAULT/GSE1827_default_gpl.csv",stringsAsFactors=FALSE)

genemap = cbind(probeset = x[,1], hgnc=toupper(map$symbol[match(x$GB_LIST, map$acc)]))
genemap = genemap[complete.cases(genemap),]

write.csv(genemap, file="../GENEMAPS/GSE1827_default_map.csv",
    row.names=FALSE,quote=FALSE)

