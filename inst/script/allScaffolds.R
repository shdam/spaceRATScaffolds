# Dataframe of all scaffolds
#

library("tibble")

allScaffolds <- tribble(
    ~name, ~version, ~umap, ~doi,
    "DMAP", 1,        TRUE, "10.5281/zenodo.10142340",
    "TCGA", 1,        TRUE, "10.5281/zenodo.10142340",
    "GTEx", 1,        TRUE, "10.5281/zenodo.10142340",
    ) |>
    as.data.frame()
allScaffolds$fullName <- paste(allScaffolds$name, allScaffolds$version, sep = ".v")
allScaffolds$filename <- paste0(allScaffolds$fullName, "_scaffold.rds")

usethis::use_data(allScaffolds, overwrite = TRUE)
