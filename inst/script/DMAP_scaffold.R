## code to prepare `DMAPv1_scaffold` dataset goes here

library("spaceRAT")

data("DMAP_exprs", "DMAP_pData", package = "spaceRATScaffolds")
DMAPv1_scaffold <- buildScaffold(
    object = DMAP_exprs,
    pheno = DMAP_pData,
    colname = "cell_types",
    data = "exprs",
    add_umap = TRUE
)
# plotScaffold(DMAPv1_scaffold,"DMAP PCA scaffold", dim_reduction = "PCA")
usethis::use_data(DMAPv1_scaffold, overwrite = TRUE)


