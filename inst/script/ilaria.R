## code to prepare `ilaria` dataset goes here

ilaria_counts <- read.csv(system.file("extdata/counts_ilaria.csv", package = "spaceRATScaffolds"))
ilaria_pData <- read.csv(system.file("extdata/pData_ilaria.csv", package = "spaceRATScaffolds"))

rownames(ilaria_counts) <- ilaria_counts$X
ilaria_counts$X <- NULL
ilaria_counts <- as.matrix(ilaria_counts)

rownames(ilaria_pData) <- ilaria_pData$X
ilaria_pData$X <- NULL
ilaria_pData$cancer_type <- as.factor(ilaria_pData$cancer_type)


usethis::use_data(ilaria_counts, overwrite = TRUE)
usethis::use_data(ilaria_pData, overwrite = TRUE)
