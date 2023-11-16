## code to prepare `TCGA_scaffold` dataset goes here

# Raw ----

library("recount3")
library("edgeR")

human_projects <- available_projects()
tcga_info <- human_projects[human_projects$file_source=="tcga",]
tcga_rse <- apply(tcga_info,1, function(x) create_rse(as.data.frame(t(x))))
cpm <- lapply(tcga_rse, function (x) {edgeR::cpm(assay(x), log=T)} )
annotation <- lapply(tcga_rse, colData)
tcga <- Reduce(cbind, cpm)
tcga_phenoData <- Reduce(rbind, annotation)

stopifnot(all(rownames(tcga_phenoData)==colnames(tcga)))

rm(counts)

library("FNN")
library("dplyr")
library("tibble")

any(colSums(tcga) == 0)

tcga_group_median <- data.frame(t(tcga), TISSUE = tcga_phenoData$study) %>% group_by(TISSUE) %>% summarise_each(list(median)) %>% as.data.frame

rownames(tcga_group_median) <- tcga_group_median$TISSUE
tcga_group_median <- tcga_group_median[,-1]


# subset to each group, and find the closest to the centroid (of that group).
sample_list = list()
for (i in rownames(tcga_group_median)) {
    if (sum(tcga_phenoData$study==i)>20){ # require e.g. at least 20 samples per group
        close_samples_in_class = as.vector(get.knnx(data = t(tcga[,tcga_phenoData$study==i]), query = tcga_group_median[i, ], 20)$nn.index)
        sample_list[[i]] = colnames(tcga[,tcga_phenoData$study==i][,close_samples_in_class])
    } else {print(paste(i, 'not enough samples'))}
}

tcga_small <- tcga[,unlist(sample_list)]
tcga_small_phenoData <- tcga_phenoData[unlist(sample_list),]

write.csv(tcga_small, file="inst/extdata/tcga_representativeSetLog2cpm.csv")
write.csv(tcga_small_phenoData, file="inst/extdata/tcga_representativeSet_metadata.csv")

rm(list=ls())

# Scaffold ----

library(spaceRAT)

tcga_exprs_scaffold <- readr::read_csv("inst/extdata/tcga_representativeSetLog2cpm.csv")
tcga_pheno_scaffold <- readr::read_csv("inst/extdata/tcga_representativeSet_metadata.csv")

colname <- "study"#"tcga.gdc_cases.project.primary_site" # tcga.gdc_cases.project.name

TCGA_scaffold <- buildScaffold(
    object = tcga_exprs_scaffold,
    pheno = tcga_pheno_scaffold,
    colname = colname,
    data = "exprs",
    classes = NULL,
    pval_cutoff = 0.05,
    lfc_cutoff = 2,
    pca_scale = FALSE,
    annotation = "ensembl_gene"
)

usethis::use_data(TCGA_scaffold, overwrite = TRUE)


# plotScaffold(TCGA_scaffold,"TCGA PCA scaffold", dim_reduction = "PCA")
