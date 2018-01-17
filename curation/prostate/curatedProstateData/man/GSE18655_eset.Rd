\name{GSE18655_eset}
\alias{GSE18655-GPL5873_eset}
\docType{data}
\title{Prostate cancer genes associated with TMPRSS2-ERG gene fusion and prognostic of biochemical recurrence in multiple cohorts.}
\description{Prostate tumors with the gene fusion TMPRSS2:ERG have been reported to have a significantly higher risk of recurrence compared with tumors lacking the fusion. Tumors from 139 patients who underwent radical prostatectomy were analyzed for the expression of 502 cancer-related genes to identify genes differentially regulated in TMPRSS2:ERG fusion tumors as well as identify biomarkers of biochemical recurrence.}
\usage{data(GSE18655_eset)}
\format{

  Authors: Barwick BG, Abramovitz M, Kodani M, Moreno CS et al

  Contact: benjamin.barwick@emory.edu

  Title:  Prostate cancer genes associated with TMPRSS2-ERG gene fusion and prognostic of biochemical recurrence in multiple cohorts.
  
  PMID: 20068566

}
\details{
  Platform used: DASL Human Cancer Panel by Gene

  139 samples.

  GEO_platform_accession: GSE186553
  platform_summary: GPL5858
  biomart_ID: DASL Human Cancer Panel by Gene

  Overall survival time-to-event summary (in years):
  Call: survfit(formula = Surv(time, cens) ~ -1)

  ___________________________________________________________________

  Available sample meta-data


  ___________________________________________________________________

  alt_sample_name:
  Length = 139.
  Class = character.
  Mode = character.

  sample_type:
  tumor = 139.

}
\source{
  http://www.ncbi.nlm.nih.gov/projects/geo/query/acc.cgi?acc=GSE18655
}
\keyword{datasets}