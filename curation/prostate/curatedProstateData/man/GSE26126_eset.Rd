\name{GSE26126_eset}
\alias{GSE26126_eset}
\docType{data}
\title{DNA methylation profiling reveals novel biomarkers and important roles for DNA methyltransferases in prostate cancer}
\description{Genome wide DNA methylation profiling of normal and tumor prostate samples, as well as cultured primary prostate cells overexpressing DNA Methyltransferases (DNMTs) and EZH2
Candidate gene based studies have identified a handful of aberrant CpG DNA methylation events in prostate cancer. However, DNA methylation profiles have not been compared on a large scale between prostate tumor and normal prostate, and the mechanisms behind these alterations are unknown. In this study, we quantitatively profiled 95 primary prostate tumors and 86 healthy prostate tissue samples for their DNA methylation levels at 26,333 CpGs representing 14,104 gene promoters by using the Illumina HumanMethylation27 platform. A 2-class Significance Analysis of this dataset revealed 5,912 CpG sites with increased DNA methylation and 2,151 CpG sites with decreased DNA methylation in tumors (FDR < 0.8 percent). Prediction Analysis of this dataset identified 87 CpGs that are the most predictive diagnostic methylation biomarkers of prostate cancer. By integrating available clinical follow-up data, we also identified 69 prognostic DNA methylation alterations that correlate with biochemical recurrence of the tumor. To identify the mechanisms responsible for these genome-wide DNA methylation alterations, we measured the gene expression levels of several DNA methyltransferases (DNMTs) and their interacting proteins by TaqMan qPCR and observed increased expression of DNMT3A2, DNMT3B, and EZH2 in tumors. Subsequent transient transfection assays in cultured primary prostate cells revealed that DNMT3B1 and DNMT3B2 overexpression resulted in increased methylation of a substantial subset of CpG sites that also showed tumor-specific increased methylation.}
\usage{data(GSE26126_eset)}
\format{

  Authors: Kobayashi Y, Absher DM, Gulzar ZG, Young SR et al.

  Contact: Yuya Kobayashi

  Title:  DNA methylation profiling reveals novel biomarkers and important roles for DNA methyltransferases in prostate cancer
  
  PMID: 21521786

}
\details{
  Platform used: Illumina HumanMethylation27 BeadChip (HumanMethylation27_270596_v.1.2)

  193 samples.

  GEO_platform_accession: GSE26126
  platform_summary: GPL8490
  biomart_ID: Illumina HumanMethylation27 BeadChip (HumanMethylation27_270596_v.1.2)

  Overall survival time-to-event summary (in years):
  Call: survfit(formula = Surv(time, cens) ~ -1)

  ___________________________________________________________________

  Available sample meta-data


  ___________________________________________________________________

  alt_sample_name:
  Length = 193.
  Class = character.
  Mode = character.

  sample_type:
  tumor = 95.

}
\source{
  http://www.ncbi.nlm.nih.gov/projects/geo/query/acc.cgi?acc=GSE26126
}
\keyword{datasets}