
DMAP_exprs <- read.csv("inst/extdata/exprs_dmap.csv")
DMAP_pData <- read.csv("inst/extdata/pData_dmap.csv")

rownames(DMAP_exprs) <- DMAP_exprs$X
DMAP_exprs$X <- NULL
DMAP_exprs <- as.matrix(DMAP_exprs)

rownames(DMAP_pData) <- DMAP_pData$X
DMAP_pData$X <- NULL
DMAP_pData$cell_types <- as.factor(DMAP_pData$cell_types)

usethis::use_data(DMAP_exprs, overwrite = TRUE)
usethis::use_data(DMAP_pData, overwrite = TRUE)
