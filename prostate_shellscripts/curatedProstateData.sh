##This script copies ExpressionSets into a shell R package directory
##and builds the MaxMean, Normalizer, and FULL versions of the
##curatedOvarianData R package.

source setvars

cd $OVHOME/curation/prostate/
rm *.tar.gz
rm $OVHOME/curation/prostate/curatedProstateData/data/*.rda

##prepare directories for Normalizer version
cp -a $OVHOME/curation/prostate/curatedProstateData $OVHOME/curation/prostate/NormalizerVcuratedProstateData
sed -i -e 's/curatedProstateData/NormalizerVcuratedProstateData/g' $OVHOME/curation/prostate/NormalizerVcuratedProstateData/DESCRIPTION
mv $OVHOME/curation/prostate/NormalizerVcuratedProstateData/man/curatedProstateData-package.Rd $OVHOME/curation/prostate/NormalizerVcuratedProstateData/man/NormalizerVcuratedProstateData-package.Rd
sed -i -e 's/curatedProstateData/NormalizerVcuratedProstateData/g' $OVHOME/curation/prostate/NormalizerVcuratedProstateData/man/NormalizerVcuratedProstateData-package.Rd
cp $OVHOME/MAPPED/DATA/Normalizer/*.rda $OVHOME/curation/Prostate/NormalizerVcuratedProstateData/data


##prepare directories for FULL version:
cp -a $OVHOME/curation/prostate/curatedProstateData $OVHOME/curation/prostate/FULLVcuratedProstateData
sed -i -e 's/curatedProstateData/FULLVcuratedProstateData/g' $OVHOME/curation/prostate/FULLVcuratedProstateData/DESCRIPTION
mv $OVHOME/curation/prostate/FULLVcuratedProstateData/man/curatedProstateData-package.Rd $OVHOME/curation/prostate/FULLVcuratedProstateData/man/FULLVcuratedProstateData-package.Rd
sed -i -e 's/curatedProstateData/FULLVcuratedProstateData/g' $OVHOME/curation/prostate/FULLVcuratedProstateData/man/FULLVcuratedProstateData-package.Rd
cp $OVHOME/MAPPED/DATA/FULL/*.rda $OVHOME/curation/prostate/FULLVcuratedProstateData/data




##copy data to MaxMean:
cp $OVHOME/MAPPED/DATA/MaxMean/*.rda $OVHOME/curation/prostate/curatedProstateData/data

##build the packages
R CMD build curatedProstateData
R CMD build NormalizerVcuratedProstateData
R CMD build FULLVcuratedProstateData

##clean-up
rm $OVHOME/curation/prostate/curatedProstateData/data/*.rda
rm -rf $OVHOME/curation/prostate/NormalizerVcuratedProstateData
rm -rf $OVHOME/curation/prostate/FULLVcuratedProstateData
