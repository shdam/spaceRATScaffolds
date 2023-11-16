# Dataframe of all scaffolds
#

library("tibble")

allScaffolds <- tribble(
    ~name, ~version, ~umap, ~zenodo,
    "DMAP", 1,        TRUE,  "",
    "TCGA", 1,        TRUE,  "",
    "GTEx", 1,        TRUE,  "",
    ) |>
    as.data.frame()
allScaffolds$fullName <- paste(allScaffolds$name, allScaffolds$version, sep = ".v")

usethis::use_data(allScaffolds, overwrite = TRUE)
