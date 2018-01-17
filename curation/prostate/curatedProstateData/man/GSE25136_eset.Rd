\name{GSE25136_eset}
\alias{GSE25136_eset}
\docType{data}
\title{Optimizing molecular signatures for predicting prostate cancer recurrence}
\description{The derivation of molecular signatures indicative of disease status and predictive of subsequent behavior could facilitate the optimal choice of treatment for prostate cancer patients. In this study, we conducted a computational analysis of gene expression profile data obtained from 79 cases, 39 of which were classified as having disease recurrence, to investigate whether advanced computational algorithms can derive more accurate prognostic signatures for prostate cancer. At the 90 percent sensitivity level, a newly derived prognostic genetic signature achieved 85 percent specificity. This is the first reported genetic signature to outperform a clinically used postoperative nomogram. Furthermore, a hybrid prognostic signature derived by combination of the nomogram and gene expression data significantly outperformed both genetic and clinical signatures, and achieved a specificity of 95 percent. Our study demonstrates the feasibility of utilizing gene expression information for highly accurate prostate cancer prognosis beyond the current clinical systems, and shows that more advanced computational modeling of tissue-derived microarray data is warranted before clinical application of molecular signatures is considered.}
\usage{data(GSE25136_eset)}
\format{

  Authors: Sun Y, Goodison S.

  Contact: steve.goodison@jax.ufl.edu

  Title:  Optimizing molecular signatures for predicting prostate cancer recurrence
  
  PMID: 19343730

}
\details{
  Platform used: [HG-U133A] Affymetrix Human Genome U133A Array

  79 samples.
  
  frma normalization used.

  GEO_platform_accession: GSE25136
  platform_summary: GPL96
  biomart_ID: [HG-U133A] Affymetrix Human Genome U133A Array

  Overall survival time-to-event summary (in years):
  Call: survfit(formula = Surv(time, cens) ~ -1)

  ___________________________________________________________________

  Available sample meta-data


  ___________________________________________________________________

  alt_sample_name:
  Length = 79.
  Class = character.
  Mode = character.

  sample_type:
  tumor = 79.

}
\source{
  http://www.ncbi.nlm.nih.gov/projects/geo/query/acc.cgi?acc=GSE25136
}
\keyword{datasets}