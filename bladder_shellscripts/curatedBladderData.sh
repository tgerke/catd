##This script copies ExpressionSets into a shell R package directory
##and builds the MaxMean, Normalizer, and FULL versions of the
##curatedBladderData R package.

source setvars

cd $OVHOME/curation/bladder/
rm *.tar.gz
rm *.pdf
rm -r $OVHOME/curation/bladder/curatedBladderData/data
rm -r NormalizerVcuratedBladderData
rm -r FULLVcuratedBladderData
mkdir $OVHOME/curation/bladder/curatedBladderData/data

##prepare directories for Normalizer version
cp -a $OVHOME/curation/bladder/curatedBladderData $OVHOME/curation/bladder/NormalizerVcuratedBladderData
sed -i -e 's/curatedBladderData/NormalizerVcuratedBladderData/g' $OVHOME/curation/bladder/NormalizerVcuratedBladderData/DESCRIPTION
sed -i -e 's/curatedBladderData/NormalizerVcuratedBladderData/g' $OVHOME/curation/bladder/NormalizerVcuratedBladderData/inst/extdata/*
mv $OVHOME/curation/bladder/NormalizerVcuratedBladderData/man/curatedBladderData-package.Rd $OVHOME/curation/bladder/NormalizerVcuratedBladderData/man/NormalizerVcuratedBladderData-package.Rd
sed -i -e 's/curatedBladderData/NormalizerVcuratedBladderData/g' $OVHOME/curation/bladder/NormalizerVcuratedBladderData/man/NormalizerVcuratedBladderData-package.Rd
cp $OVHOME/MAPPED/DATA/Normalizer/*.rda $OVHOME/curation/bladder/NormalizerVcuratedBladderData/data
cp $OVHOME/MAPPED/DATA/Normalizer/*.Rd $OVHOME/curation/bladder/NormalizerVcuratedBladderData/man
rm -r $OVHOME/curation/bladder/NormalizerVcuratedBladderData/inst/doc



##prepare directories for FULL version:
cp -a $OVHOME/curation/bladder/curatedBladderData $OVHOME/curation/bladder/FULLVcuratedBladderData
sed -i -e 's/curatedBladderData/FULLVcuratedBladderData/g' $OVHOME/curation/bladder/FULLVcuratedBladderData/DESCRIPTION
sed -i -e 's/curatedBladderData/FULLVcuratedBladderData/g' $OVHOME/curation/bladder/FULLVcuratedBladderData/inst/extdata/*
mv $OVHOME/curation/bladder/FULLVcuratedBladderData/man/curatedBladderData-package.Rd $OVHOME/curation/bladder/FULLVcuratedBladderData/man/FULLVcuratedBladderData-package.Rd
sed -i -e 's/curatedBladderData/FULLVcuratedBladderData/g' $OVHOME/curation/bladder/FULLVcuratedBladderData/man/FULLVcuratedBladderData-package.Rd
cp $OVHOME/MAPPED/DATA/FULL/*.rda $OVHOME/curation/bladder/FULLVcuratedBladderData/data
cp $OVHOME/MAPPED/DATA/FULL/*.Rd $OVHOME/curation/bladder/FULLVcuratedBladderData/man
rm -r $OVHOME/curation/bladder/FULLVcuratedBladderData/inst/doc


##copy data to MaxMean:
cp $OVHOME/MAPPED/DATA/MaxMean/*.rda $OVHOME/curation/bladder/curatedBladderData/data
cp $OVHOME/MAPPED/DATA/MaxMean/*.Rd $OVHOME/curation/bladder/curatedBladderData/man

##build the packages
$REXEC CMD build curatedBladderData
$REXEC CMD build NormalizerVcuratedBladderData
$REXEC CMD build FULLVcuratedBladderData
$REXEC CMD Rd2pdf curatedBladderData
$REXEC CMD Rd2pdf NormalizerVcuratedBladderData
$REXEC CMD Rd2pdf FULLVcuratedBladderData

##clean-up
#rm $OVHOME/curation/bladder/curatedBladderData/data/*.rda
#rm -rf $OVHOME/curation/bladder/NormalizerVcuratedBladderData
#rm -rf $OVHOME/curation/bladder/FULLVcuratedBladderData
