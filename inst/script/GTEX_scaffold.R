## code to prepare `GTEX_scaffold` dataset goes here
# library(spaceRAT)

counts_scaffold <- readr::read_csv(system.file("extdata/gtex_representativeSetLog2cpm.csv", package = "spaceRATScaffolds"))
pheno_scaffold <- readr::read_csv(system.file("extdata/gtex_representativeSet_metadata.csv", package = "spaceRATScaffolds"))

colname <- "gtex.smts"

# GTEX_scaffold <- buildScaffold(
#     object = counts_scaffold,
#     pheno_scaffold = pheno_scaffold,
#     colname = colname,
#     data = "logged",
#     dims = c(1,2),
#     dim_reduction = "PCA",
#     plot_mode = "dot",
#     classes = NULL,
#     pval_cutoff = 0.05,
#     lfc_cutoff = 2,
#     title = "GTEX PCA scaffold",
#     pca_scale = FALSE,
#     auto_plot = FALSE,
#     annotation = "ensembl_gene"
#     )

# plotScaffold(GTEX_scaffold,"GTEX PCA scaffold")

usethis::use_data(GTEX_scaffold, overwrite = TRUE)
