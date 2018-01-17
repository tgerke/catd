inname = "gseids.txt"
inname1 = open(inname, "r")
inname2 = [v.strip() for v in inname1.readlines()]
output = open("publicdatasetswithhyperlinks.txt", "w")

for item in inname2:
    output.write('=HYPERLINK("http://cen1.dfci.harvard.edu/repos/curation/prostate/curated/"' + item + '"_curated_pdata.txt","curated"')
    output.write("\n")

output.close()
