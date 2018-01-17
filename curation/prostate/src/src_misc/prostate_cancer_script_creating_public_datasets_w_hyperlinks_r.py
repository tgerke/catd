inname = "gseids.txt"
inname1 = open(inname, "r")
inname2 = [v.strip() for v in inname1.readlines()]
output = open("publicdatasetswithhyperlinks_R.txt", "w")

for item in inname2:
    output.write('=HYPERLINK("http://cen1.dfci.harvard.edu/repos/curation/prostate/src/"' + item + '"_curation.r","src")')
    output.write("\n")
    

output.close()
