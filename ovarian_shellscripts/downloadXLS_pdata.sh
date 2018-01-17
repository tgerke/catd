##one-time only script, used to get metadata for PMID15897565, which
##was then added to the subversion repository.

source setvars

$REXEC CMD BATCH --vanilla "--args PMID15897565 $UNCURATED https://discovery.genome.duke.edu/express/resources/1144/arrayWebSiteClinicalData2005.xls 1 2" $SRCHOME/downloadXLS_pdata.R $LOG/PMID15897565_downloadXLS_pdata.log
