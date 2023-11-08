## code to prepare `TCGA_scaffold` dataset goes here

library(spaceRAT)

tcga_exprs_scaffold <- readr::read_csv("inst/extdata/tcga_representativeSetLog2cpm.csv")
tcga_pheno_scaffold <- readr::read_csv("inst/extdata/tcga_representativeSet_metadata.csv")

colname <- "study"#"tcga.gdc_cases.project.primary_site" # tcga.gdc_cases.project.name

TCGA_scaffold <- buildScaffold(
    object = tcga_exprs_scaffold,
    pheno = tcga_pheno_scaffold,
    colname = colname,
    data = "exprs",
    classes = NULL,
    pval_cutoff = 0.05,
    lfc_cutoff = 2,
    pca_scale = FALSE,
    annotation = "ensembl_gene"
)

usethis::use_data(TCGA_scaffold, overwrite = TRUE)


# plotScaffold(TCGA_scaffold,"TCGA PCA scaffold", dim_reduction = "PCA")
