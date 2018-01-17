##This script copies ExpressionSets into a shell R package directory
##and builds the MaxMean, Normalizer, and FULL versions of the
##curatedOvarianData R package.

source setvars

cd $OVHOME/curation/CRC/
rm *.tar.gz
rm $OVHOME/curation/CRC/curatedCRCData/data/*.rda

##prepare directories for Normalizer version
cp -a $OVHOME/curation/CRC/curatedCRCData $OVHOME/curation/CRC/NormalizerVcuratedCRCData
sed -i -e 's/curatedCRCData/NormalizerVcuratedCRCData/g' $OVHOME/curation/CRC/NormalizerVcuratedCRCData/DESCRIPTION
mv $OVHOME/curation/CRC/NormalizerVcuratedCRCData/man/curatedCRCData-package.Rd $OVHOME/curation/CRC/NormalizerVcuratedCRCData/man/NormalizerVcuratedCRCData-package.Rd
sed -i -e 's/curatedCRCData/NormalizerVcuratedCRCData/g' $OVHOME/curation/CRC/NormalizerVcuratedCRCData/man/NormalizerVcuratedCRCData-package.Rd
cp $OVHOME/MAPPED/DATA/Normalizer/*.rda $OVHOME/curation/CRC/NormalizerVcuratedCRCData/data


##prepare directories for FULL version:
cp -a $OVHOME/curation/CRC/curatedCRCData $OVHOME/curation/CRC/FULLVcuratedCRCData
sed -i -e 's/curatedCRCData/FULLVcuratedCRCData/g' $OVHOME/curation/CRC/FULLVcuratedCRCData/DESCRIPTION
mv $OVHOME/curation/CRC/FULLVcuratedCRCData/man/curatedCRCData-package.Rd $OVHOME/curation/CRC/FULLVcuratedCRCData/man/FULLVcuratedCRCData-package.Rd
sed -i -e 's/curatedCRCData/FULLVcuratedCRCData/g' $OVHOME/curation/CRC/FULLVcuratedCRCData/man/FULLVcuratedCRCData-package.Rd
cp $OVHOME/MAPPED/DATA/FULL/*.rda $OVHOME/curation/CRC/FULLVcuratedCRCData/data




##copy data to MaxMean:
cp $OVHOME/MAPPED/DATA/MaxMean/*.rda $OVHOME/curation/CRC/curatedCRCData/data

##build the packages
R CMD build curatedCRCData
R CMD build NormalizerVcuratedCRCData
R CMD build FULLVcuratedCRCData

##clean-up
rm $OVHOME/curation/CRC/curatedCRCData/data/*.rda
rm -rf $OVHOME/curation/CRC/NormalizerVcuratedCRCData
rm -rf $OVHOME/curation/CRC/FULLVcuratedCRCData
