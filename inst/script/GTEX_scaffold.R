## code to prepare `GTEX` dataset goes here

# Raw ----

library("recount3")
library("edgeR")


human_projects <- available_projects()

gtex_info <- human_projects[human_projects$file_source=="gtex",]
gtx_rse <- apply(gtex_info,1, function(x) create_rse(as.data.frame(t(x))))
cpm <- lapply(gtx_rse, function (x) {edgeR::cpm(assay(x), log=T)} )
annotation <- lapply(gtx_rse, colData)
gtex <- Reduce(cbind, cpm)
gtex_phenoData <- Reduce(rbind, annotation)

stopifnot(all(rownames(gtex_phenoData)==colnames(gtex)))

# check if this is counts or cpm...
gtex[10000:10020, 10000:10020]
rm(cpm)

#write.csv(gtex, "/Volumes/My Passport/recount3/gtex_raw_counts.txt")
#write.csv(gtex_phenoData, "/Volumes/My Passport/recount3/gtex_metadata.txt")


# there are ways to reduce the datas set if too big.




library("FNN")
library("dplyr")
library("tibble")

# find median in log2 cpm space
gtex_group_median <- data.frame(t(gtex), TISSUE=gtex_phenoData$gtex.smts) %>%
    group_by(TISSUE) %>%
    summarise_each(list(median)) %>%
    as.data.frame

gtex_group_median$TISSUE[is.na(gtex_group_median$TISSUE)] <- "NoInfo"
gtex_phenoData$gtex.smtsd[is.na(gtex_phenoData$gtex.smtsd)] <- "NoInfo"
gtex_phenoData$gtex.smts[is.na(gtex_phenoData$gtex.smts)] <- "NoInfo"

rownames(gtex_group_median) <- gtex_group_median$TISSUE
gtex_group_median <- gtex_group_median[,-1]



# subset to each group, and find the closest to the centroid (of that group).  in log2 cpm space
sample_list <- list()
for (i in rownames(gtex_group_median)) {
    if (sum(gtex_phenoData$gtex.smts==i)>10){ # require at least 20 samples per group
        close_samples_in_class <- as.vector(get.knnx(data = t(gtex[,gtex_phenoData$gtex.smts==i]), query = gtex_group_median[i, ], 10)$nn.index)
        sample_list[[i]] <- colnames(gtex[,gtex_phenoData$gtex.smts==i][,close_samples_in_class])
    }
}

gtex_small <- gtex[,unlist(sample_list)]
gtex_small_phenoData <- gtex_phenoData[unlist(sample_list),]

# Remove the no info
# gtex_small <- gtex[,gtex_small_phenoData$gtex.smts!="NoInfo"]
# gtex_small_phenoData <- gtex_small_phenoData[gtex_small_phenoData$gtex.smts!="NoInfo",]




write.csv(gtex_small, file="inst/extdata/gtex_representativeSetLog2cpm.csv")
write.csv(gtex_small_phenoData, file="inst/extdata/gtex_representativeSet_metadata.csv")


# Scaffold ----
rm(list=ls())
library("spaceRAT")
# devtools::load_all("../spaceRAT/")
gtex_exprs <- readr::read_csv("inst/extdata/gtex_representativeSetLog2cpm.csv")
gtex_pheno <- readr::read_csv("inst/extdata/gtex_representativeSet_metadata.csv")

gtex_exprs <- as.data.frame(gtex_exprs)
rownames(gtex_exprs) <- gtex_exprs[[1]]
gtex_exprs[[1]] <- NULL

colname <- "gtex.smts"
gtex_exprs <- gtex_exprs[, gtex_pheno$gtex.smts != "NoInfo"]
gtex_pheno <- gtex_pheno[gtex_pheno$gtex.smts != "NoInfo", ]


## V1 ----
# gtex_exprs <- gtex_exprs[gsub("\\.[0-9]+$","", gtex_exprs[[1]]) %in% rownames(ilaria_counts),]
# gtex_exprs <- gtex_exprs[gtex_exprs[[1]] != "NA",]
GTEx.v1 <- buildScaffold(
  object = gtex_exprs,# t(gtex_reverted), #gtex_exprs
  pheno = gtex_pheno,
  colname = "gtex.smts",
  data = "exprs",
  # classes = unique(gtex_pheno$gtex.smts) |> stringr::str_remove(c("(Bone Marrow|Testis)")),
  # pca_scale = TRUE,
  pval_cutoff = 0.01,
  lfc_cutoff = 1,
  n_genes = 200,
  # sort.by = "logFC", #"p"
  pca_scale = TRUE,
  rank_scale = T,
  # annotation = "ensembl_gene",
  # add_umap = TRUE
)

plotScaffold(GTEx.v1,"GTEX PCA scaffold", dimred = "PCA", dims = c(1,2))

# Projection
data("ilaria_counts", "ilaria_pData", package = "spaceRATScaffolds")
projectSample(GTEx.v1,ilaria_counts,ilaria_pData,"cancer_type", title = "GTEx", dims = c(1,2), subset_intersection = F)


# Save scaffold in extdata to be put on Zenodo
saveRDS(GTEx.v1, file = "inst/extdata/GTEx.v1.rds")
GTEx.v1 <- "getScaffold('GTEx.v1')"
usethis::use_data(GTEx.v1, overwrite = TRUE)



## V2 ----
gtex_pca <- prcomp(t(gtex_exprs), scale. = TRUE)
gtex_pca$x[,1:2] <- 0
gtex_reverted <- gtex_pca$x %*% t(gtex_pca$rotation) + matrix(rep(gtex_pca$center, ncol(gtex_exprs)), nrow = ncol(gtex_exprs), ncol = nrow(gtex_exprs), byrow = TRUE)

GTEx.v2 <- buildScaffold(
    object = t(gtex_reverted), #gtex_exprs
    pheno = gtex_pheno,
    colname = "gtex.smts",
    data = "exprs",
    # classes = unique(gtex_pheno$gtex.smts) |> stringr::str_remove(c("(Bone Marrow|Testis)")),
    # pca_scale = TRUE,
    pval_cutoff = 0.01,
    lfc_cutoff = 1,
    n_genes = 200,
    # sort.by = "logFC", #"p"
    pca_scale = TRUE,
    rank_scale = T,
    # annotation = "ensembl_gene",
    #ranking = TRUE
    # add_umap = TRUE
)
plotScaffold(GTEx.v2,"GTEX PCA scaffold", dimred = "PCA", dims = c(1,2))

# Save scaffold in extdata to be put on Zenodo
saveRDS(GTEx.v2, file = "inst/extdata/GTEx.v2.rds")
GTEx.v2 <- "getScaffold('GTEx.v2')"
usethis::use_data(GTEx.v2, overwrite = TRUE)

data("ilaria_counts", "ilaria_pData", package = "spaceRATScaffolds")
projectSample(GTEx.v2,ilaria_counts,ilaria_pData,"cancer_type", title = "GTEx", dims = c(3,4))

# projectSample(GTEx.v1,ilaria_counts,ilaria_pData,"cancer_type", title = "GTEx", dims = c(1,3),
#               classes = unique(gtex_pheno$gtex.smts) |> stringr::str_remove(c("(Bone Marrow|Testis)")))

# projectSample(GTEx.v1,gtex_exprs[, gtex_pheno$gtex.smts == "Muscle"], colname = "cancer_type", title = "GTEx", dims = c(1,2))

