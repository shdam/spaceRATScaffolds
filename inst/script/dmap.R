
exprs_dmap <- read.csv(system.file("extdata/exprs_dmap.csv", package = "spaceRATScaffolds"))
pData_dmap <- read.csv(system.file("extdata/pData_dmap.csv", package = "spaceRATScaffolds"))

rownames(exprs_dmap) <- exprs_dmap$X
exprs_dmap$X <- NULL

rownames(pData_dmap) <- pData_dmap$X
pData_dmap$X <- NULL
pData_dmap$cell_types <- as.factor(pData_dmap$cell_types)

usethis::use_data(exprs_dmap, overwrite = TRUE)
usethis::use_data(pData_dmap, overwrite = TRUE)
