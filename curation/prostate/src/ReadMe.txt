To add to comments in final draft:
1) For substage (where the values are pathological, not clinical), I determined this based on the fact that the values for stage fit the allowedvalues for "overall_stage_pathological."  That is, when all the stage values fit in the overall_stage_pathological template values, I determined that "substage" must refer to pathological substage as opposed to "substage_clinical."  Please confirm that this was accurate

2) "overall_stage_clinical" and "overall_stage_pathological" share one value in common-- "4".  My approach was to put a "4" as "overall_stage_pathological" when all the rest of the stage values in that dataset corresponded to the allowedvalues for "overall_stage_pathological."  However, if a "4" was part of a dataset where the other stage values in the dataset corresponded to "overall_stage_clinical", then the "4" would be put into "overall_stage_clinical" (although, so far I have not yet seen the latter case).  Please confirm that this is accurate.


6) GSE8511
a) do we even want this study?  ~11 of the samples have gleason sum, and the rest it has is sample_type...
b) sample_type the metastatic ones are clear, but it's not obvious whether the others are "tumor" or "healthy"...
- i went w/ "benign" becoming "adjacentnormal", metastatic becoming "metastasis", and "local" becoming "tumor"


7) GSE10645-GPL5858 (all 3 + and all three 10645-GPL5873):
a) can i do anything w/ "characteristics_ch1" case-Control Group:[Systemic|PSA|NSA]?!?
b) can i do anything w/ "characteristics_ch1.1" training or validation: [trn|val]?!?
c) does the column w/ values: PSA(ng/ml) at RRP: [decimal] -- correspond to our template column header "psa_at_diagnosis" ?  This is how I translated it...
d) what does their: StageT[integer][a-c]N0 correspond w/ in our template?  T_clinical or just T?  I'm going with 
e) NED also says tumor next to it...
f) They have a column saying things like: "Ploidy: tetraploid" or "Ploidy: diploid"--this refers to number of sets of chromosomes in a cell...do we want this?
g) they have first rising PSA, time to first rising, second rising-- do we want any of this??
h) Whaat about "time from PSA recurrence to systemic disease?"


8) GSE14206
a) there is a column w/ values "ets group: ERG_High" or "ets group: NoETS" or "ets group: ESE3_Low"...do we want these?  If so, how to curate?

9) GSE16560
a) do we want the values "batch: [2|3|etc]"; "extreme:[Indolent|Lethal]"; "cancer percent:[1-9|1-9]"; "diagnosis year: 1988, etc";  

10) GSE18655
a) they havge gleason grade and then they have a separate column that says "grade: [1|2|3]".  I don't know what this refers to and it doesn't fit our template; so for now this separate "grade" column is not included into the curated file.
b) I have a few questions when converting the values beginning "pathologic stage category: " into the curated version.
 i) extraprostatic extension is larger than seminal_vesicle_invasion, right?
For example, the uncurated file looks like:
pathologic stage category: extraprostatic
pathologic stage category: seminal vesicle invasion
pathologic stage category: organ confined
pathologic stage category: extraprostatic
pathologic stage category: organ confined


My code does the following:
#extraprostatic_extension (y/n)
tmp <- uncurated$characteristics_ch1.8
tmp[tmp=="pathologic stage category: extraprostatic"] <- "y"
curated$extraprostatic_extension <- tmp

Should I also make is so that values of "seminal_vesicle_invasion" become "y" in the curated$extraprostatic_extension? 
ii) Should I assume that if the uncurated says "extraprostatic" that it is not seminal vescile invasion since there is a specific one for seminal vesicle invasion?  

For example,

curated$seminal_vesicle_invasion should only be "y" when  the words "seminal vescile invasion" literally appear...?

11) GSE20132-GPL5188

for our curated$sample_type, kinda confused.  I ended up taking column N "uncurated$characteristics_ch1.3" and only for the rows w/ values in them.  But taking "uncurated$source_name_ch1" instead looks like some of the values could be adjacentnormal, and these are blank in the way that I currently took it.  (My way is preferable because it distinguishes "tumors" from "metastasis", this is not done in the latter case).

b) Did I curate "clint_stage" and "pathological_stage" correctly?  As "overall_stage_clinical" and "overall_stage_pathological", respectively?

12) GSE21032-GPL8227, GSE21032-GPL10264
Is this a valid platform for our analysis?

13) GSE23022
a) not quite sure how to translate to "curated$sample_type".  For example, it says in uncurated: "disease state: normal control" for a few of them. But then under source_name_ch1 in uncurated, they all say "radical_prostatectomy_specimen"
So I grabbed the ones that say "disease state: primary prostate cancer"...

My code looks like the following:

##sample_type
tmp <- ifelse(uncurated$characteristics_ch1.1=="disease state: Primary prostate cancer","tumor","adjacentnormal")
curated$sample_type <- tmp

b) I took "tumor stage: pT..." to mean overall_stage_pathological because the values are the ones we have in the template.  But please, please, please provide clarification, since this seems like an important distinction we are making and I want to ensure this is the correct translation.

14) GSe26126
a) How should i curate the "normal" ones?  It says "disease state: Normal" for some in the uncurated, but they also have associated psa values and gleason scores.  It does not say adjacentnormal but this is what it is, no?
I curated it like this:
#sample_type
tmp <- uncurated$characteristics_ch1.2
tmp[tmp=="disease state: Tumor"] <- "tumor"
tmp[tmp=="disease state: Normal"] <- "adjacentnormal"
curated$sample_type <- tmp
b) for recurrence_status, I did the following:
#recurrence_status
tmp <- uncurated$characteristics_ch1.7
tmp[tmp=="recurrence: None"] <- "norecurrence"
tmp[tmp=="recurrence: Biochemical"] <- "recurrence"
curated$recurrence_status <- tmp

Does "biochemical" become "recurrence?"  If not, it is very odd, but I want to make sure.

c) Did I curate days_to_recurrence and _days_to_death correctly?  They have two columns available so I took both....















