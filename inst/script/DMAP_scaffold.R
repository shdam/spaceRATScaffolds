## code to prepare `DMAP_scaffold` dataset goes here

library(spaceRAT)

data("DMAP_exprs", "DMAP_pData", package = "spaceRATScaffolds")
DMAP_scaffold <- buildScaffold(
    object = DMAP_exprs,
    pheno = DMAP_pData,
    colname = "cell_types",
    data = "exprs",
    add_umap = TRUE
)
# plotScaffold(DMAP_scaffold,"DMAP PCA scaffold", dim_reduction = "PCA")
usethis::use_data(DMAP_scaffold, overwrite = TRUE)


