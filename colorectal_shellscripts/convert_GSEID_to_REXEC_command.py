#This is a convenience script to take a list of GEO IDs and create the shell script which downloads the processed microarray data and metadata.
#Created by Ben Ganzfried for the initial download of uncurated data from GEO. 
#infile.txt: one study ID per line, eg. GSE500

inname = "colorectalGSEIDs.txt"
inname1 = open(inname, "r")
inname2 = [v.strip() for v in inname1.readlines()]
output = open("downloadPROCESSED_colorectal.txt", "w")

for item in inname2:
    output.write('$REXEC CMD BATCH --vanilla "--args ' + item + ' $DATAHOME" $SRCHOME/gse_PROCESSED.R $LOG/' + item + '_downloadPROCESSED.log\n')

    
output.close()
