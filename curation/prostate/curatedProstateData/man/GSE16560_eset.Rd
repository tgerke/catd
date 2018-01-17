\name{GSE16560_eset}
\alias{GSE16560_eset}
\docType{data}
\title{Molecular sampling of prostate cancer: a dilemma for predicting disease progression}
\description{Current prostate cancer prognostic models are based on pre-treatment prostate-specific antigen (PSA) levels, biopsy Gleason score, and clinical staging but in practice are inadequate to accurately predict clinical disease progression. Hence, we sought to develop a molecular panel for prostate cancer progression by reasoning that molecular profiles might further improve current clinical models. We analyzed a Swedish Watchful Waiting cohort (1977–1999) with up to 30 years of clinical follow up using a novel method for gene expression profiling. This cDNA-mediated annealing, selection, ligation, and extension (DASL) method enabled the use of formalin-fixed paraffin-embedded transurethral resection of prostate (TURP) samples taken at the time of the initial diagnosis. We determined the expression profiles of 6100 genes for 281 men divided in two extreme groups: men who died of prostate cancer or developed metastases and men who survived more than 10 years without metastases (lethals and indolents, respectively). Several models using clinical and molecular features were evaluated for their ability to distinguish lethal from indolent cases. Surprisingly, none of the predictive models using molecular profiles significantly improved over models using clinical variables only. We reasoned that tumor sampling might preclude the identification of the dominant metastatic nodule. Additional computational analysis confirmed that molecular heterogeneity within both the lethal and indolent classes is widespread in prostate cancer as compared to other types of tumors. Thus the determination of the molecularly dominant tumor nodule may be limited by sampling at time of initial diagnosis, may not be present at time of initial diagnosis, or may occur as the disease progresses preventing the development of molecular biomarkers for prostate cancer progression.}
\usage{data(GSE16560_eset)}
\format{

  Authors: Sboner A, Demichelis F, Calza S, Pawitan Y et al.

  Contact: ans2077@med.cornell.edu

  Title:  Molecular sampling of prostate cancer: a dilemma for predicting disease progression
  
  PMID: 20233430

}
\details{
  Platform used: Human 6k Transcriptionally Informative Gene Panel for DASL

  281 samples.

  GEO_platform_accession: GSE16560
  platform_summary: GPL5474
  biomart_ID: Human 6k Transcriptionally Informative Gene Panel for DASL

  Overall survival time-to-event summary (in years):
  Call: survfit(formula = Surv(time, cens) ~ -1)

  ___________________________________________________________________

  Available sample meta-data


  ___________________________________________________________________

  alt_sample_name:
  Length = 281.
  Class = character.
  Mode = character.

  sample_type:
  tumor = 281.

}
\source{
  http://www.ncbi.nlm.nih.gov/projects/geo/query/acc.cgi?acc=GSE16560
}
\keyword{datasets}