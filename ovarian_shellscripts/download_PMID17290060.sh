source setvars

URL="https://discovery.genome.duke.edu/express/resources/1144/PlatinumJCO.zip"

strInputAccession="PMID17290060"
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

unzip PlatinumJCO.zip
rm PlatinumJCO.zip

