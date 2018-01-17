source setvars

for file in `find $DATAHOME -name "*_curated_*"`;do rsync -v $file $OVHOME/FINAL/DEFAULT;done
for file in `find $DATAHOME -name "*rma_*"`;do rsync -v $file $OVHOME/FINAL/RMA;done
