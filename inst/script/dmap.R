
DMAP_exprs <- read.csv(system.file("extdata/exprs_dmap.csv", package = "spaceRATScaffolds"))
DMAP_pData <- read.csv(system.file("extdata/pData_dmap.csv", package = "spaceRATScaffolds"))

rownames(DMAP_exprs) <- DMAP_exprs$X
DMAP_exprs$X <- NULL
DMAP_exprs <- as.matrix(DMAP_exprs)

rownames(DMAP_pData) <- DMAP_pData$X
DMAP_pData$X <- NULL
DMAP_pData$cell_types <- as.factor(DMAP_pData$cell_types)

usethis::use_data(DMAP_exprs, overwrite = TRUE)
usethis::use_data(DMAP_pData, overwrite = TRUE)
