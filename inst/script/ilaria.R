## code to prepare `ilaria` dataset goes here

library(spaceRAT)

exprs_ilaria <- read.csv(system.file("extdata/exprs_ilaria.csv", package = "spaceRATScaffolds"))
pData_ilaria <- read.csv(system.file("extdata/pData_ilaria.csv", package = "spaceRATScaffolds"))

rownames(exprs_ilaria) <- exprs_ilaria$X
exprs_ilaria$X <- NULL

rownames(pData_ilaria) <- pData_ilaria$X
pData_ilaria$X <- NULL

usethis::use_data(exprs_ilaria, overwrite = TRUE)
usethis::use_data(pData_ilaria, overwrite = TRUE)
