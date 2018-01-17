\name{GSE7949_eset}
\alias{GSE7949_eset}
\docType{data}
\title{Prostate Adenocarcinoma: Candidate Genomic Signatures Prognostic of Biochemical Failure}
\description{Prostate cancer is the most common form of non-skin cancer in American men. Although the 5-year survival rate is 100 percent, an important proportion of patients will recur after seven years following treatment. Despite attempts to delineate clinical and molecular prognostic signatures of recurrence, accurate prediction remains an elusive task. The purpose of this project was, therefore, to identify candidate genomic signatures of biochemical failure present at the moment of diagnosis. To do this, we carried out array comparative genomic hybridization on surgical specimens from a training cohort of patients with PRCA who were followed on average for ten years. Due to the unstable nature of malignant genomes, we selected non-random genomic aberrations through Significance Testing of Aberrant Copy Number (STAC), a statistical permutation algorithm. Further analysis of STAC regions between recurrent and non-recurrent groups showed that recurring cases had a greater proportion of gain in 4p14-12, 11p14.3-14.1 or 15q21.1-22.2 in comparison to non-recurrent cases. All three genomic signatures were independently, better predictors of recurrence than previously known clinical covariates. The importance of these regions in PRCA progression was further validated in publicly available expression data sets, where over-expression of ADAM10, BDNF and CYP19A1 (all coded in the aforementioned regions) was found to increase with progression of disease. We hypothesize that amplification of ADAM10, BDNF, and CYP19A1 may serve as candidate biomarkers of recurrence to be validated in larger datasets.}
\usage{data(GSE7949_eset)}
\format{

  Authors: Oquendo CE, Lal P, Korenblit M, D'Andrea K, Rinaldi K, Ping L, Shang W, Gimotty PA, Malkowicz SB, Tomaszewski JE, Nathanson KL

  Contact: oquendoc@mail.med.upenn.edu

  Title: Prostate Adenocarcinoma: Candidate Genomic Signatures Prognostic of Biochemical Failure

}
\details{
  Platform used: University of Pennsylvania/Nathanson Lab_HomoSapiens_ChromosomeRegion_Virtual

  21 samples.

  GEO_platform_accession: GSE7949
  platform_summary: GPL5338
  biomart_ID: University of Pennsylvania/Nathanson Lab_HomoSapiens_ChromosomeRegion_Virtual

  Overall survival time-to-event summary (in years):
  Call: survfit(formula = Surv(time, cens) ~ -1)

  ___________________________________________________________________

  Available sample meta-data


  ___________________________________________________________________

  alt_sample_name:
  Length = 21.
  Class = character.
  Mode = character.

  sample_type:
  tumor = 21.

}
\source{
  http://www.ncbi.nlm.nih.gov/projects/geo/query/acc.cgi?acc=GSE7949
}
\keyword{datasets}