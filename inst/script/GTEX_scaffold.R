## code to prepare `GTEX_scaffold` dataset goes here
library(spaceRAT)

gtex_exprs_scaffold <- readr::read_csv("inst/extdata/gtex_representativeSetLog2cpm.csv")
gtex_pheno_scaffold <- readr::read_csv("inst/extdata/gtex_representativeSet_metadata.csv")

colname <- "gtex.smts"

GTEX_scaffold <- buildScaffold(
    object = gtex_exprs_scaffold,
    pheno = gtex_pheno_scaffold,
    colname = colname,
    data = "exprs",
    classes = NULL,
    pval_cutoff = 0.05,
    lfc_cutoff = 2,
    pca_scale = FALSE,
    annotation = "ensembl_gene"
    )

# plotScaffold(GTEX_scaffold,"GTEX PCA scaffold", dim_reduction = "PCA")

usethis::use_data(GTEX_scaffold, overwrite = TRUE)
