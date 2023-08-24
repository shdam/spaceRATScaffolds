## code to prepare `ilaria` dataset goes here

counts_ilaria <- read.csv(system.file("extdata/counts_ilaria.csv", package = "spaceRATScaffolds"))
pData_ilaria <- read.csv(system.file("extdata/pData_ilaria.csv", package = "spaceRATScaffolds"))

rownames(counts_ilaria) <- counts_ilaria$X
counts_ilaria$X <- NULL
counts_ilaria <- as.matrix(counts_ilaria)

rownames(pData_ilaria) <- pData_ilaria$X
pData_ilaria$X <- NULL
pData_ilaria$cancer_type <- as.factor(pData_ilaria$cancer_type)


usethis::use_data(counts_ilaria, overwrite = TRUE)
usethis::use_data(pData_ilaria, overwrite = TRUE)
