##one-time only script, used to get metadata for GSE1827, which
##was then added to the subversion repository.

source setvars

$REXEC CMD BATCH --vanilla "--args GSE1827 $UNCURATED http://waldman.ucsf.edu/Blaveri/Clinical.xls 1 0" $SRCHOME/downloadXLS_pdata.R $LOG/GSE1827_downloadXLS_pdata.log

$REXEC CMD BATCH --vanilla "--args PMID16432078 $UNCURATED http://jco.ascopubs.org/content/suppl/2006/01/24/JCO.2005.03.2375.DC1/Supplementary_Table_1._Sanchez-Carbayo_et_al.xls 0 0" $SRCHOME/downloadXLS_pdata.R $LOG/PMID16432078_downloadXLS_pdata.log
