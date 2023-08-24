## code to prepare `GTEX_scaffold` dataset goes here
library(spaceRAT)

exprs_scaffold <- readr::read_csv(system.file("extdata/gtex_representativeSetLog2cpm.csv", package = "spaceRATScaffolds"))
pheno_scaffold <- readr::read_csv(system.file("extdata/gtex_representativeSet_metadata.csv", package = "spaceRATScaffolds"))

colname <- "gtex.smts"

GTEX_scaffold <- buildScaffold(
    object = exprs_scaffold,
    pheno_scaffold = pheno_scaffold,
    colname = colname,
    data = "logged",
    classes = NULL,
    pval_cutoff = 0.05,
    lfc_cutoff = 2,
    pca_scale = FALSE,
    annotation = "ensembl_gene"
    )

# plotScaffold(GTEX_scaffold,"GTEX PCA scaffold", dim_reduction = "PCA")

usethis::use_data(GTEX_scaffold, overwrite = TRUE)
