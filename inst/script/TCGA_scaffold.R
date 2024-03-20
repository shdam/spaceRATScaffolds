## code to prepare `TCGA` dataset goes here

# Raw ----

library("recount3")
library("edgeR")

human_projects <- available_projects()
tcga_info <- human_projects[human_projects$file_source=="tcga",]
tcga_rse <- apply(tcga_info,1, function(x) create_rse(as.data.frame(t(x))))
cpm <- lapply(tcga_rse, function (x) {edgeR::cpm(assay(x), log=TRUE)} )
annotation <- lapply(tcga_rse, colData)
tcga <- Reduce(cbind, cpm)
tcga_phenoData <- Reduce(rbind, annotation)

stopifnot(all(rownames(tcga_phenoData)==colnames(tcga)))

# check if this is counts or cpm...
tcga[10000:10020, 10000:10020]
rm(cpm)

library("FNN")
library("dplyr")
library("tibble")

any(colSums(tcga) == 0)

tcga_group_median <- data.frame(t(tcga), TISSUE = tcga_phenoData$study) %>% group_by(TISSUE) %>% summarise_each(list(median)) %>% as.data.frame

rownames(tcga_group_median) <- tcga_group_median$TISSUE
tcga_group_median <- tcga_group_median[,-1]


# subset to each group, and find the closest to the centroid (of that group).
sample_list = list()
n_samples <- 10

for (i in rownames(tcga_group_median)) {
  if (sum(tcga_phenoData$study==i)>n_samples){ # require e.g. at least 20 samples per group
    close_samples_in_class <- as.vector(get.knnx(data = t(tcga[,tcga_phenoData$study==i]), query = tcga_group_median[i, ], n_samples)$nn.index)
    sample_list[[i]] <- colnames(tcga[,tcga_phenoData$study==i][,close_samples_in_class])
  } else {print(paste(i, 'not enough samples'))}
}

tcga_small <- tcga[,unlist(sample_list)]
tcga_small_phenoData <- tcga_phenoData[unlist(sample_list),]

write.csv(tcga_small, file="inst/extdata/tcga_representativeSetLog2cpm.csv")
write.csv(tcga_small_phenoData, file="inst/extdata/tcga_representativeSet_metadata.csv")

rm(list=ls())

# Scaffold ----

library("spaceRAT")
# devtools::load_all("../spaceRAT/")

tcga_exprs <- readr::read_csv("inst/extdata/tcga_representativeSetLog2cpm.csv")
tcga_pheno <- readr::read_csv("inst/extdata/tcga_representativeSet_metadata.csv")
tcga_exprs <- as.data.frame(tcga_exprs)
rownames(tcga_exprs) <- tcga_exprs[[1]]
tcga_exprs[[1]] <- NULL
colname <- "study"#"tcga.gdc_cases.project.primary_site" # tcga.gdc_cases.project.name
# tcga_exprs <- tcga_exprs[gsub("\\.[0-9]+$","", tcga_exprs[[1]]) %in% overlap_genes,]
# tcga_exprs <- tcga_exprs[tcga_exprs[[1]] != "NA",]


# V1 ----
TCGA.v1 <- buildScaffold(
    object = tcga_exprs,
    pheno = tcga_pheno,
    colname = "study",
    data = "exprs",
    classes = NULL,
    # pca_scale = TRUE,
    pval_cutoff = 0.01,
    lfc_cutoff = 2,
    n_genes = 200,
    # sort.by = "logFC" #"p"
    pca_scale = TRUE,
    rank_scale = TRUE,
    # annotation = "ensembl_gene",
    #ranking = TRUE
    # add_umap = TRUE
)

plotScaffold(TCGA.v1, "TCGA PCA scaffold", dimred = "PCA", dims = c(1,2))

# Save scaffold in extdata to be put on Zenodo
saveRDS(TCGA.v1, file = "inst/extdata/TCGA.v1.rds")
TCGA.v1 <- "TCGA.v1 <- getScaffold('TCGA.v1')"
usethis::use_data(TCGA.v1, overwrite = TRUE)

# Plat scaffold
data("ilaria_counts", "ilaria_pData", package = "spaceRATScaffolds")
projectSample(TCGA.v1,ilaria_counts,ilaria_pData,"cancer_type", title = "TCGA - 200 genes, lfc=2 -PC1 (1,2)", dims = c(1,2),
              subset_intersection = F)




# V2 ----
tcga_pca <- prcomp(t(tcga_exprs), scale. = TRUE)
tcga_pca$x[,1] <- 0
tcga_reverted <- tcga_pca$x %*% t(tcga_pca$rotation) + matrix(rep(tcga_pca$center, ncol(tcga_exprs)), nrow = ncol(tcga_exprs), ncol = nrow(tcga_exprs), byrow = TRUE)

# tcga_reverted <- predict(tcga_pca, t(tcga_exprs)) %*% t(tcga_pca$rotation) + matrix(rep(tcga_pca$center, ncol(tcga_exprs)), nrow = ncol(tcga_exprs), ncol = nrow(tcga_exprs), byrow = TRUE)

# tcga_exprs / tcga_pca$sdev[2]^2

TCGA.v2 <- buildScaffold(
  object = t(tcga_reverted),
  pheno = tcga_pheno,
  colname = "study",
  data = "exprs",
  classes = NULL,
  # pca_scale = TRUE,
  pval_cutoff = 0.01,
  lfc_cutoff = 2,
  n_genes = 200,
  # sort.by = "logFC" #"p"
  pca_scale = TRUE,
  rank_scale = TRUE,
  # annotation = "ensembl_gene",
  #ranking = TRUE
  # add_umap = TRUE
)

plotScaffold(TCGA.v2, "TCGA PCA scaffold", dimred = "PCA", dims = c(1,2))

# Save scaffold in extdata to be put on Zenodo
saveRDS(TCGA.v2, file = "inst/extdata/TCGA.v2.rds")
TCGA.v2 <- readRDS("inst/extdata/TCGA.v2.rds")

data("ilaria_counts", "ilaria_pData", package = "spaceRATScaffolds")

projectSample(TCGA.v2,ilaria_counts,ilaria_pData,"cancer_type", title = "TCGA - 200 genes, lfc=2 -PC1 (1,2)", dims = c(1,2),
              subset_intersection = F)

scaffold <- TCGA.v1
rownames(scaffold$rank) <- rownames(scaffold$rank) |> 
  stringr::str_remove("_.*")

ilaria_subset <- spaceRAT:::preFilter(ilaria_counts, "counts")
ilaria_pca <- prcomp(t(ilaria_subset), scale. = TRUE)
ilaria_pca$x[,2] <- 0
ilaria_counts2 <- ilaria_pca$x %*% t(ilaria_pca$rotation) + matrix(rep(ilaria_pca$center, ncol(ilaria_subset)), nrow = ncol(ilaria_subset), ncol = nrow(ilaria_subset), byrow = TRUE)


# projectSample(scaffold,ilaria_counts,ilaria_pData,"cancer_type", title = "TCGA", dims = c(1,2), pca_scale = FALSE)
projectSample(TCGA.v2,ilaria_counts,ilaria_pData,"cancer_type", title = "TCGA - 200 genes, lfc=2 -PC1 (1,2)", dims = c(3,4),
              subset_intersection = F,
               # classes = c("ACC", "BLCA", "BRCA", "CESC", "CHOL", "COAD", "DLBC", "ESCA", "GBM",  "HNSC", "KICH", "KIRC", "KIRP",
               #             "LAML",
               #             "LGG",
               #             "LIHC", "LUAD", "LUSC", "MESO", "OV",   "PAAD", "PCPG", "PRAD", "READ", "SARC", "SKCM",
               #             "STAD", "TGCT", "THCA", "THYM", "UCEC", "UCS",  "UVM" ),
               # scale = TRUE
               )

adjustment <- rowMeans(tcga_exprs -  t(tcga_reverted))
adjustment <- as.numeric((tcga_exprs -  t(tcga_reverted))[1,])

# new_exprs <- tcga_exprs - (tcga_exprs -  t(tcga_reverted))
new_exprs <- apply(tcga_exprs, 1, function(x) x-adjustment )
new_exprs <- t(apply(tcga_exprs, 1, function(x) x - adjustment))
new_exprs <- sweep(tcga_exprs, 1, adjustment, "-")

new_exprs <- tcga_exprs

subset <- "GBM"
new_exprs <- new_exprs[, tcga_pheno[which(tcga_pheno$study == subset),1, drop =T]]
projectSample(TCGA.v1,new_exprs, title = paste("TCGA +", subset, "samples"), dims = c(1,2))

subset <- "Blood"
new_exprs <- gtex_exprs[, gtex_pheno[which(gtex_pheno$gtex.smts == subset),1, drop =T]]
projectSample(TCGA.v1,new_exprs, title = paste("TCGA +", subset, "samples"), dims = c(3,4))

devtools::load_all("../spaceRAT/")

params <- tibble::tribble(
  ~Case, ~Scaffold, ~pval, ~lfc, ~n_genes, ~Method,
  1, "TCGA", 0.01, 1, Inf, "groupScaling + no normalization",
  2, "TCGA", 0.01, 1, Inf, "groupScaling + sample normalization",
  3, "TCGA", 0.01, 1, Inf, "groupScaling + sample normalization (dims 1,3)",
  4, "TCGA", 0.01, 1, Inf, "groupScaling + sample normalization (dims 2,3)",
  5, "TCGA", 0.01, 1, Inf, "groupScaling + sdev[1] normalization (dims 1,2)",
  6, "TCGA", 0.01, 1.5, Inf, "groupScaling + sdev[1] normalization (dims 1,2)",
  7, "TCGA", 0.01, 2, Inf, "groupScaling + no normalization (dims 1,2)",
  8, "TCGA", 0.01, 2.5, Inf, "groupScaling + no normalization (dims 1,2)",
  9, "TCGA", 0.01, 2, 100, "groupScaling + no normalization (dims 1,2)",
  10, "TCGA", 0.01, 1, 50, "groupScaling + no normalization (dims 1,2)",
  11, "TCGA", 0.01, 1, 200, "groupScaling + no normalization (dims 1,2)",
  12, "TCGA", 0.01, 1, 600, "groupScaling + no normalization (dims 1,2)",
)

saveRDS(TCGA.v2, file = "inst/extdata/TCGA.v2.rds")
TCGA.v2 <- "TCGA.v2 <- getScaffold('TCGA.v2')"
usethis::use_data(TCGA.v2, overwrite = TRUE)
