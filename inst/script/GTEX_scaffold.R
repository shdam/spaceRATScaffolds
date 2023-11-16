## code to prepare `GTEX_scaffold` dataset goes here

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
gtex_group_median <- data.frame(t(gtex), TISSUE=gtex_phenoData$gtex.smts) %>% group_by(TISSUE) %>% summarise_each(list(median)) %>% as.data.frame

gtex_group_median$TISSUE[is.na(gtex_group_median$TISSUE)] = "NoInfo"
gtex_phenoData$gtex.smtsd[is.na(gtex_phenoData$gtex.smtsd)] = "NoInfo"
gtex_phenoData$gtex.smts[is.na(gtex_phenoData$gtex.smts)] = "NoInfo"

rownames(gtex_group_median) <- gtex_group_median$TISSUE
gtex_group_median <- gtex_group_median[,-1]



# subset to each group, and find the closest to the centroid (of that group).  in log2 cpm space
sample_list <- list()
for (i in rownames(gtex_group_median)) {
    if (sum(gtex_phenoData$gtex.smts==i)>20){ # require at least 20 samples per group
        close_samples_in_class <- as.vector(get.knnx(data = t(gtex[,gtex_phenoData$gtex.smts==i]), query = gtex_group_median[i, ], 20)$nn.index)
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

gtex_exprs_scaffold <- readr::read_csv("inst/extdata/gtex_representativeSetLog2cpm.csv")
gtex_pheno_scaffold <- readr::read_csv("inst/extdata/gtex_representativeSet_metadata.csv")

colname <- "gtex.smts"

GTEx.v1_scaffold <- buildScaffold(
    object = gtex_exprs_scaffold,
    pheno = gtex_pheno_scaffold,
    colname = colname,
    data = "exprs",
    classes = NULL,
    pval_cutoff = 0.05,
    lfc_cutoff = 2,
    pca_scale = FALSE,
    annotation = "ensembl_gene",
    add_umap = TRUE
    )

# plotScaffold(GTEX_scaffold,"GTEX PCA scaffold", dimred = "PCA")

# Save scaffold in extdata to be put on Zenodo
saveRDS(GTEx.v1_scaffold, file = "inst/extdata/GTEx.v1_scaffold.rds")
