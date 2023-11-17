## code to prepare `DMAPv1_scaffold` dataset goes here

library("spaceRAT")

data("DMAP_exprs", "DMAP_pData", package = "spaceRATScaffolds")
DMAP.v1 <- buildScaffold(
    object = DMAP_exprs,
    pheno = DMAP_pData,
    colname = "cell_types",
    data = "exprs",
    add_umap = TRUE
)
# plotScaffold(DMAPv1_scaffold,"DMAP PCA scaffold", dim_reduction = "PCA")
# Save scaffold in extdata to be put on Zenodo
saveRDS(DMAP.v1, file = "inst/extdata/DMAP.v1_scaffold.rds")
DMAP.v1 <- "getScaffold('DMAP.v1')"
usethis::use_data(DMAP.v1, overwrite = TRUE)
