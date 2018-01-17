##one-time script for moving uncurated metadata all to one directory.
##Run after ./downloadPROCESSED.sh, before doing curation.

source setvars

for file in `find $DATAHOME -name "*full_pdata.*"`;do cp $file $UNCURATED;done
