inname = "second_check_input.txt"
inname1 = open(inname, "r")
inname2 = [v.strip() for v in inname1.readlines()]
output = open("output_second_check.txt", "w")

for item in inname2:
    output.write('$REXEC CMD BATCH --vanilla "--args ' + item + ' $DATAHOME" $SRCHOME/gse_PROCESSED.R $LOG/' + item + '_downloadPROCESSED.log\n')

    
output.close()
