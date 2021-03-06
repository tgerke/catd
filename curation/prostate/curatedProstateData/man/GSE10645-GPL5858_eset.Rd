\name{GSE10645-GPL5858_eset}
\alias{GSE10645-GPL5858_eset}
\docType{data}
\title{A tissue biomarker panel predicting systemic progression after PSA recurrence post-definitive prostate cancer therapy}
\description{After therapy for prostate cancer many men develop a rising PSA. Such men may develop a local or metastatic recurrence that warrants further therapy. However many men will have no evidence of disease progression other than the rising PSA and will have a good outcome. A case-control design, incorporating test and validation cohorts, was used to test the association of gene expression results with outcome after PSA recurrence.
Since clinical training and validation analysis requires tissue from patients with sufficient follow-up time, for this study we sampled individuals from the Mayo Radical Retropubic Prostatectomy (RRP) Registry. The registry consists of a population of men who received prostatectomy as their first treatment for prostate cancer at the Mayo Clinic (For a current description and use of the registry; see PMID: 17418069). As systemic progression is relatively infrequent, we designed a case-control study nested within a cohort of men with a rising PSA. Between 1987-2001, inclusive, 9,989 previously-untreated men had RRP at Mayo. On follow-up, 2,131 developed a rising PSA (>30 days after RRP) in the absence of concurrent clinical recurrence. PSA rise was defined as a follow-up PSA >= 0.20 ng/ml, with the next PSA at least 0.05 ng/ml higher or the initiation of treatment for PSA recurrence (for patients whose follow-up PSA was high enough to warrant treatment). This group of 2,131 men comprises the underlying cohort from which SYS cases and PSA controls were selected.
Within 5 years of PSA rise, 213 men developed systemic progression (SYS cases), defined as a positive bone scan or CT scan. Of these, 100 men succumbed to a prostate cancer-specific death, 37 died from other causes and 76 remain at risk.
PSA recurrence controls (213) were selected from those men without systemic progression within 5 years after the PSA rise and were matched (1:1) on birth year, calendar year of PSA rise and initial diagnostic pathologic Gleason score (<=6, 7+). Twenty of these men developed systemic progression greater than 5 years after initial PSA rise and 9 succumbed to a prostate cancer-specific death.
A set of 213 No Evidence of Disease (NED) Progression controls were also selected from the Mayo RRP Registry of 9,989 men and used for some comparisons. These controls had RRP from 1987-1998 with no evidence of PSA rise within 7 years of RRP. The median (25th, 75th percentile) follow-up from RRP was 11.3 (9.3, 13.8) years. The NED controls were matched to the systemic progression cases on birth-year, calendar year of RRP and initial diagnostic Gleason Score. Computerized optimal matching was performed to minimize the total distance between cases and controls in terms of the sum of the absolute difference in the matching factors (PMID: 8728456).
All paraffin-embedded blocks from eligible men were identified and each block was surveyed for the tissue present (primary and secondary Gleason cancer regions, normal and metastatic lymph nodes, etc.). Of the 639 eligible patients, paraffin blocks were available on 623 (97.5 percent). Similarly, RNA was successfully isolated and the DASL assays successfully performed on a very high proportion of patients/specimens: Usable RNA was prepared from all 623 blocks, and the Cancer Panel and custom prostate cancer panel DASL arrays were both successful on 596 RNA specimens (95.7% of RNAs; 93.3% of design patients)}
\usage{data(GSE10645-GPL5858_eset)}
\format{

  Authors: Kollmeyer TM, Nakagawa T, Morlan BW, Anderson SK, Bergstrahl EJ, Davis BJ, Asmann YW, Cunningham JM, Klee GG, Ballman KV, Jenkins RB

  Contact: rjenkins@mayo.edu

  Title:  A tissue biomarker panel predicting systemic progression after PSA recurrence post-definitive prostate cancer therapy.
  
  PMID: 18846227

}
\details{
  Platform used: DASL Human Cancer Panel by Gene

  596 samples.

  GEO_platform_accession: GSE10645-GPL5858
  platform_summary: GPL5858
  biomart_ID: DASL Human Cancer Panel by Gene

  Overall survival time-to-event summary (in years):
  Call: survfit(formula = Surv(time, cens) ~ -1)

  ___________________________________________________________________

  Available sample meta-data


  ___________________________________________________________________

  alt_sample_name:
  Length = 596.
  Class = character.
  Mode = character.

  sample_type:
  tumor = 596.

}
\source{
  http://www.ncbi.nlm.nih.gov/projects/geo/query/acc.cgi?acc=GSE10645-GPL5858
}
\keyword{datasets}