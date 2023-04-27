## code to prepare `DMAP_scaffold` dataset goes here

library(spaceRAT)

exprs_dmap <- readr::read_csv(system.file("extdata/exprs_dmap.csv", package = "spaceRATScaffolds"), show_col_types = FALSE)
pData_dmap <- readr::read_csv(system.file("extdata/pData_dmap.csv", package = "spaceRATScaffolds"), show_col_types = FALSE)
DMAP_scaffold <- buildScaffold(
    object = exprs_dmap,
    pheno_scaffold = pData_dmap,
    colname = "cell_types"
)


usethis::use_data(DMAP_scaffold, overwrite = TRUE)

usethis::use_data(exprs_dmap, overwrite = TRUE)

usethis::use_data(pData_dmap, overwrite = TRUE)
