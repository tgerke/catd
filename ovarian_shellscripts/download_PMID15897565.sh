source setvars

URL="https://discovery.genome.duke.edu/express/resources/1144/survival_CEL_files.zip"

strInputAccession="PMID15897565"
strBaseDir=$DATAHOME
celDir=$strBaseDir/$strInputAccession
processedDir=$celDir/PROCESSED
defaultDir=$processedDir/DEFAULT


mkdir $strBaseDir
mkdir $celDir
mkdir $celDir/RAW
mkdir $processedDir
mkdir $defaultDir

cd $celDir/RAW

wget --timestamping $URL

unzip survival_CEL_files.zip
rm survival_CEL_files.zip

