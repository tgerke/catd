##This script copies ExpressionSets into a shell R package directory
##and builds the MaxMean, Normalizer, and FULL versions of the
##curatedOvarianData R package.

source setvars

cd $OVHOME/curation/ovarian/
rm *.tar.gz
rm -r $OVHOME/curation/ovarian/curatedOvarianData/data
rm -r NormalizerVcuratedOvarianData
rm -r FULLVcuratedOvarianData
mkdir $OVHOME/curation/ovarian/curatedOvarianData/data

##prepare directories for Normalizer version
cp -a $OVHOME/curation/ovarian/curatedOvarianData $OVHOME/curation/ovarian/NormalizerVcuratedOvarianData
sed -i -e 's/curatedOvarianData/NormalizerVcuratedOvarianData/g' $OVHOME/curation/ovarian/NormalizerVcuratedOvarianData/DESCRIPTION
mv $OVHOME/curation/ovarian/NormalizerVcuratedOvarianData/man/curatedOvarianData-package.Rd $OVHOME/curation/ovarian/NormalizerVcuratedOvarianData/man/NormalizerVcuratedOvarianData-package.Rd
sed -i -e 's/curatedOvarianData/NormalizerVcuratedOvarianData/g' $OVHOME/curation/ovarian/NormalizerVcuratedOvarianData/man/NormalizerVcuratedOvarianData-package.Rd
sed -i -e 's/curatedOvarianData/NormalizerVcuratedOvarianData/g' $OVHOME/curation/ovarian/NormalizerVcuratedOvarianData/inst/unitTests/*
sed -i -e 's/curatedOvarianData/NormalizerVcuratedOvarianData/g' $OVHOME/curation/ovarian/NormalizerVcuratedOvarianData/tests/*
cp $OVHOME/MAPPED/DATA/Normalizer/*.rda $OVHOME/curation/ovarian/NormalizerVcuratedOvarianData/data
rm -r $OVHOME/curation/ovarian/NormalizerVcuratedOvarianData/inst/doc

##prepare directories for FULL version:
cp -a $OVHOME/curation/ovarian/curatedOvarianData $OVHOME/curation/ovarian/FULLVcuratedOvarianData
sed -i -e 's/curatedOvarianData/FULLVcuratedOvarianData/g' $OVHOME/curation/ovarian/FULLVcuratedOvarianData/DESCRIPTION
mv $OVHOME/curation/ovarian/FULLVcuratedOvarianData/man/curatedOvarianData-package.Rd $OVHOME/curation/ovarian/FULLVcuratedOvarianData/man/FULLVcuratedOvarianData-package.Rd
sed -i -e 's/curatedOvarianData/FULLVcuratedOvarianData/g' $OVHOME/curation/ovarian/FULLVcuratedOvarianData/man/FULLVcuratedOvarianData-package.Rd
sed -i -e 's/curatedOvarianData/FULLVcuratedOvarianData/g' $OVHOME/curation/ovarian/FULLVcuratedOvarianData/inst/unitTests/*
sed -i -e 's/curatedOvarianData/FULLVcuratedOvarianData/g' $OVHOME/curation/ovarian/FULLVcuratedOvarianData/tests/*
cp $OVHOME/MAPPED/DATA/FULL/*.rda $OVHOME/curation/ovarian/FULLVcuratedOvarianData/data
rm -r $OVHOME/curation/ovarian/FULLVcuratedOvarianData/inst/doc


##copy data to MaxMean:
cp $OVHOME/MAPPED/DATA/MaxMean/*.rda $OVHOME/curation/ovarian/curatedOvarianData/data

##build the packages
$REXEC CMD build curatedOvarianData
$REXEC CMD build NormalizerVcuratedOvarianData
$REXEC CMD build FULLVcuratedOvarianData
$REXEC CMD check *.tar.gz
$REXEC CMD Rd2pdf curatedOvarianData
$REXEC CMD Rd2pdf NormalizerVcuratedOvarianData
$REXEC CMD Rd2pdf FULLVcuratedOvarianData

##clean-up
# rm $OVHOME/curation/ovarian/curatedOvarianData/data/*.rda
# rm -rf $OVHOME/curation/ovarian/NormalizerVcuratedOvarianData
# rm -rf $OVHOME/curation/ovarian/FULLVcuratedOvarianData
