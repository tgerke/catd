source setvars

URL="https://discovery.genome.duke.edu/express/resources/74/suppmat.zip"

strInputAccession="PMID19318476"
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
wget --no-directories --timestamping $URL
unzip suppmat.zip
rm suppmat.zip
mv suppmat/* .
mv data/batch1/*.cel .
mv data/batch2/*.cel .
mv data/batch3/*.cel .
mv data/late/*.cel .
rm -rf suppmat data

cp batches.txt "$defaultDir"/"$strInputAccession"_batches.txt
cp NewClin.txt "$defaultDir"/"$strInputAccession"_full_pdata.txt
find `pwd` -name "*.cel" -fprint "$defaultDir"/"$strInputAccession"_RAWfilenames.txt
