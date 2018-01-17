\name{TCGA_eset}
\alias{TCGA_eset}
\docType{data}
\title{Ovarian serous cystadenocarcinoma: Sample Counts and Findings}
\description{The Cancer Genome Atlas}
\usage{data(TCGA_eset)}
\format{

Authors: The Cancer Genome Atlas.

Title: Ovarian serous cystadenocarcinoma: Sample Counts and Findings.

Url: http://tcga-data.nci.nih.gov/tcga/tcgaCancerDetails.jsp?diseaseType=OV&diseaseName=Ovarian\%20serous\%20cystadenocarcinoma

}
\details{
rma normalization used from the rma bioconductor package.

assayData: 12858 features, 570 samples.

GEO_platform_accession: TCGA

platform_summary: GPL4685

biomart_ID: HT-HG_U133A affy_hg_u133a

Overall survival time-to-event summary (in years): 

Call: survfit(formula = Surv(time, cens) ~ -1)

records = 576.  n.max = 576. n.start = 576.  events = 0. median = NA. 0.95LCL = NA. 0.95UCL = NA.

-------------------------------------------------------------------------------


Available sample meta-data: 

-------------------------------------------------------------------------------

alt_sample_name: 
Length = 576.
Class = character.
Mode = character.

unique_patient_ID: 
Length = 576.
Class = character.
Mode = character.

sample_type: 
tumor = 576.

subtype: 
ser = 576.

primarysite: 
ov = 576.

G: 
1 = 6.
2 = 68.
3 = 485.
4 = 1.

days_to_death: 
Min. = 8  Median = 1024   Mean = 1083.22  Max. = 4623

batch: 
Length = 570.
Class = character.
Mode = character.

}
\examples{
data(TCGA_eset)
## maybe str(TCGA_eset) ; plot(TCGA_eset) ...

if(require(affy)){
  summary(TCGA_eset$recurrence_status)
  time <- TCGA_eset$days_to_death / 365
  cens <- ifelse(TCGA_eset$vital_status=="deceased",1,0)
  library(survival)
  fit <- survfit(Surv(time,cens)~-1)
  fit          #for summary of survival
  summary(fit)
  plot(fit,xlab="Time (years)",ylab="Survivor function")
  inverse.fit <- survfit(Surv(time,1-cens) ~ -1)
  inverse.fit  #for summary of follow-up time
}
}
\keyword{datasets}
