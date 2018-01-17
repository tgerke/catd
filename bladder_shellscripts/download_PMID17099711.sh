source setvars

URL="http://www.ebi.ac.uk/arrayexpress/files/E-TABM-147/E-TABM-147.raw"
URLCLINICAL="http://www.ebi.ac.uk/arrayexpress/files/E-TABM-147/E-TABM-147.sdrf.txt"

strInputAccession="PMID17099711"
strBaseDir=$DATAHOME 
celDir=$strBaseDir/$strInputAccession
processedDir=$celDir/PROCESSED
defaultDir=$processedDir/DEFAULT


mkdir $strBaseDir
mkdir $celDir
mkdir $celDir/RAW
mkdir -p $celDir-GPL91/PROCESSED/DEFAULT
mkdir -p $celDir-GPL8300/PROCESSED/DEFAULT
mkdir -p $celDir/PROCESSED/DEFAULT

cd $celDir/RAW
wget --no-directories --timestamping $URL.1.zip
wget --no-directories --timestamping $URL.2.zip
wget --no-directories --timestamping $URLCLINICAL
unzip E-TABM-147.raw.1.zip 
unzip E-TABM-147.raw.2.zip
rm E-TABM-147*.zip
rm ._P*.CEL

cp E-TABM-147.sdrf.txt "$celDir"/PROCESSED/DEFAULT/"$strInputAccession"_full_pdata.txt
find `pwd` -name "*U95A.CEL" > "$celDir"-GPL91/PROCESSED/DEFAULT/"$strInputAccession"-GPL91_RAWfilenames.txt
find `pwd` -name "*u95av2.CEL" > "$celDir"-GPL8300/PROCESSED/DEFAULT/"$strInputAccession"-GPL8300_RAWfilenames.txt
