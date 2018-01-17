# Summary #

This is a data pipeline for building clinically-annotated
transcriptome data packages.  It contains curated data for lung,
prostate, colorectal, and bladder cancer (bladder due to Markus
Riester).  This pipeline builds three versions of the package:

* curated: selects the probeset with maximum mean to represent each
  gene (http://cran.r-project.org/web/packages/WGCNA/index.html
  collapseRows function)
* NormalizerVcurated: discards probesets with expression patterns more
  similar to background than to other probesets for the same gene,
  then averages any remaining probesets (if any are remaining):
  http://huttenhower.sph.harvard.edu/sleipnir/Normalizer.
* FULLVcuratedOvarianData: does not collapse redundant probesets at
  all, and just provides original probesets.

So the first two have one row per gene symbol, and the FULL version
has one row per probeset.

------------------------------------------------------
------------------------------------------------------
# Requirements #

## R libraries: ##

Needed CRAN and Bioconductor libraries are installed as part of the
pipeline, and can be found in src/install_needed_packages.R.

## External programs: ##

blast_gene_maps.R depends on NCBI blast, in particular makeblastdb and
blastn.  It has been tested with this version:
ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.2.25+-x64-linux.tar.gz

The makeblastdb and blastn executables must be in the shell search path, test this by:

    which makeblastdb
    which blastn

If these return nothing, then you need to install NCBI blast before
running this pipeline.

## Shell environment: ##

Some R code and shell scripts depend on a GNU/Linux environment, and
may even be bash-specific.

geneMapper.R: depends on the Normalizer program (v1.0) from the
Sleipnir library
(http://www.huttenhower.org/content/getting-started-sleipnir) for
averaging of duplicate probes mapped to the same gene, with exclusion
of outliers.  Source code is available from the Sleipnir project, and
a compiled binary is also provided for convenience in the
shellscripts/ directory.

The ovarian repository was built on Ubuntu 11.04, but should be
replicable on any Linux platform.  Versions used for R and R packages
are shown at the end of this file.

------------------------------------------------------
------------------------------------------------------

# Running the pipeline #

With makeblastdb and blastn from the NCBI blast program in the
executable search path, the entire pipeline can be run as follows:

       cd shellscripts
       ./runall.sh

# Greater detail about the pipeline #
------------------------------------------------------

Start by looking in the shellscripts/ directory - these scripts
execute the entire pipeline, using source code in src/, some
configuration files in etc/, and curated metadata in curation/.  Many
of these scripts are one-line-per-dataset for the purposes of the
curatedOvarianData repository, but can easily be extended by shell
script loops to an arbitrary numbers of datasets.

------------------------------------------------------
------------------------------------------------------
shellscripts/

Below are descriptions of the shell scripts and the order to run them
in.

---------------------
runall.sh

Run everything.

---------------------
setvars

Set environmental variables such as the location of the R executable
and the directories to use.

In the shell scripts that actually do things, you specify the
experiments you need.  For example:

---------------------
downloadRAW.sh

download and unpack raw data (if available).  Also removes CEL files
of the wrong platform, but this requires "platform_map.txt" in the
src/ directory.

Note that when a series (GSE) contains more than one platform (GPL),
you should specify which platform you want.  For example if there is
only one platform,

$REXEC CMD BATCH --vanilla "--args GSE19829 $DATAHOME" $SRCHOME/gse_PROCESSED.R $LOG/GSE19829_downloadPROCESSED.log

But if there are two platforms and you only want GPL570:

$REXEC CMD BATCH --vanilla "--args GSE20565 $DATAHOME GPL570" $SRCHOME/gse_PROCESSED.R $LOG/GSE20565_downloadPROCESSED.log

If there are 2+ platforms and you don't specify a platform, each
platform will be downloaded as a separate dataset (either that or an
error).  When a series has multiple platforms, they end up getting
treated as separate datasets with names like: GSE20565-GPL570

---------------------
downloadPROCESSED.sh

download the processed data as provided by the authors.  This also
downloads the platform file from GEO (the map between identifiers,
gene symbols, etc).

Note there are also some sample scripts for individual non-GEO
datasets, eg download_PMID19318476.sh, for downloading data from
miscellaneous websites etc.

---------------------
miscellaneous individual datasets not in a repository would be
downloaded at this point:

download_PMID15897565.sh
downloadPROBLEMS.sh
download_PMID19318476.sh
download_PMID17290060.sh

--------------------- 
QC.sh: optional, produce a quality control report for the datasets.
Doesn't work in many cases.  Svitlana has a better version but hasn't
incorporated it into the repository.

---------------------
curation.sh

This runs all the curation scripts which turn uncurated metadata into
curated metadata.  This has already been done in, for example,
curation/prostate/curated, but this script:

1) runs the curation scripts again

2) runs the syntax-checking script again.  After it runs, you can
check the curated/ERRORS directory to make sure the curated files pass
the error checks.  Error checks are based on the template in the
curation/prostate/src directory (a different template for each
cancer).  The name of the template file for syntax-checking can be
found in this line of src/checkCurated.R:

template <- read.csv(paste(present.dir,"/Prostate_Draft_Template_June_1_2011.csv",sep=""),as.is=TRUE)

---------------------
attach_PROCESSED.sh

Read raw data filenames, processed data sample names, and curated
metadata sample names, and remove any filenames or sample names which
do not match between expression data and metadata.  

---------------------
preprocess_AFFY.sh

This runs frozen RMA for Affy hgu133a and hgu133plus2, RMA for other
Affy platforms, and currently does nothing for other platforms.
Written to be easy to plug in other preprocessing methods, or override
the defaults.

---------------------
downloadXLS_pdata.sh

For some metadata which is downloaded in the form of an excel
spreadsheet, this calls a script to extract data from excel
spreadsheets and write to plain text file.

---------------------
geneMapper.sh, ovariangeneMapper.sh

Map probe identifiers to gene symbols.  Use ovariangeneMapper.sh to do
this for the ovarian datasets using generated map files, geneMapper.sh
to do it using the default GEO GPLs.


---------------------
moveFINAL.sh

Just a convenience script to grab processed expression data from
individual study directories and put them all in one place.

---------------------
moveUNCURATED.sh

Ben uses this after running downloadPROCESSED.sh to move all the
uncurated metadata into a single directory.

---------------------
createEsets.sh

This script goes to the directories containing expression data mapped
to gene symbols, in MAPPED/DATA, and creates .rda files containing R
ExpressionSets for each dataset, with expression data and curated
clinical data.

---------------------
curatedOvarianData.sh

Build three versions of the actual R package, and run R CMD check.

------------------------------------------------------
------------------------------------------------------
src/

---------------------
getPlatforms.R

Make maps for platforms that are available from Biomart (Ensembl)

---------------------
blast_gene_maps.R

check all downloaded GPLs from GEO for target sequences.  If
available, use BLAST to make a gene map.

---------------------
match_datasets_to_platformmaps.R

Read each table of expression values, and plot how many can be mapped.
Should be done after all expression data are downloaded/processed, and
after running getPlatforms.R and blast_gene_maps.R.


------------------------------------------------------
------------------------------------------------------
geneSigDB/

signatures downloaded from geneSigDB.  Not a part of the downloading
pipeline, just an add-on for the ovarian project.

------------------------------------------------------
------------------------------------------------------

curation/ovarian/ contains curated metadata.  Within this directory,
there is:

       src/
       uncurated/
       curated/
       curatedOvarianData/

containing uncurated metadata, R scripts used for curation, the
curated metadata, and the source curatedOvarianData package, minus the
.rda files.  To build the final R package, copy the .rda files from
one of the subdirectories of MAPPED/DATA in to a subdirectory of this
directory called data/, and run R CMD BUILD curatedOvarianData.

-----------------------------------------------------
-----------------------------------------------------

> sessionInfo()
R version 2.15.0 (2012-03-30)
Platform: x86_64-unknown-linux-gnu (64-bit)

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
 [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
 [7] LC_PAPER=C                 LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C            
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
 [1] grid      splines   tools     stats     graphics  grDevices utils    
 [8] datasets  methods   base     

other attached packages:
 [1] arrayQualityMetrics_3.12.0 affyPLM_1.32.0            
 [3] preprocessCore_1.20.0      gcrma_2.30.0              
 [5] frma_1.8.0                 gplots_2.11.0             
 [7] KernSmooth_2.23-8          caTools_1.13              
 [9] bitops_1.0-4.1             gtools_2.7.0              
[11] GEOquery_2.23.5            lumi_2.10.0               
[13] nleqslv_1.9.4              gdata_2.12.0              
[15] WGCNA_1.23-1               MASS_7.3-22               
[17] reshape_0.8.4              plyr_1.7.1                
[19] cluster_1.14.2             Hmisc_3.9-3               
[21] survival_2.36-14           flashClust_1.01-2         
[23] dynamicTreeCut_1.21        impute_1.32.0             
[25] biomaRt_2.12.0             affyio_1.24.0             
[27] affy_1.36.0                Biobase_2.16.0            
[29] BiocGenerics_0.4.0        

loaded via a namespace (and not attached):
 [1] affxparser_1.30.0    annotate_1.36.0      AnnotationDbi_1.20.0
 [4] beadarray_2.8.0      BeadDataPackR_1.10.0 BiocInstaller_1.4.7 
 [7] Biostrings_2.26.1    bit_1.1-8            Cairo_1.5-1         
[10] codetools_0.2-8      colorspace_1.1-1     DBI_0.2-5           
[13] ff_2.2-7             foreach_1.4.0        genefilter_1.40.0   
[16] GenomicRanges_1.10.1 hwriter_1.3          IRanges_1.16.2      
[19] iterators_1.0.6      lattice_0.20-10      latticeExtra_0.6-24 
[22] limma_3.14.0         Matrix_1.0-9         methylumi_2.4.0     
[25] mgcv_1.7-21          nlme_3.1-104         oligo_1.22.0        
[28] oligoClasses_1.20.0  parallel_2.15.0      RColorBrewer_1.0-5  
[31] RCurl_1.95-0.1.2     reshape2_1.2.1       RSQLite_0.11.2      
[34] setRNG_2011.11-2     stats4_2.15.0        stringr_0.6.1       
[37] SVGAnnotation_0.93-1 vsn_3.26.0           XML_3.95-0.1        
[40] xtable_1.7-0         zlibbioc_1.4.0      
> 
