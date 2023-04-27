## code to prepare `DMAP_scaffold` dataset goes here

library(spaceRAT)

data("exprs_dmap", "pData_dmap", package = "spaceRATScaffolds")
DMAP_scaffold <- buildScaffold(
    object = exprs_dmap,
    pheno_scaffold = pData_dmap,
    colname = "cell_types"
)

usethis::use_data(DMAP_scaffold, overwrite = TRUE)


