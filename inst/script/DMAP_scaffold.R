## code to prepare `DMAPv1_scaffold` dataset goes here

library("spaceRAT")

data("DMAP_exprs", "DMAP_pData", package = "spaceRATScaffolds")
# DMAP_exprs <- DMAP_exprs[rownames(DMAP_exprs) %in% rownames(ilaria_counts),]
DMAP.v1 <- buildScaffold(
    object = DMAP_exprs,
    pheno = DMAP_pData,
    colname = "cell_types",
    data = "exprs",
    # add_umap = TRUE
)

plotScaffold(DMAP.v1,"DMAP PCA scaffold", dimred = "PCA")
plotScaffold(DMAP.v1,"DMAP PCA scaffold", dimred = "UMAP")
projectSample(DMAP.v1, ilaria_counts,ilaria_pData,"cancer_type", subset_intersection = F, dimred = 'UMAP')

# Save scaffold in extdata to be put on Zenodo
saveRDS(DMAP.v1, file = "inst/extdata/DMAP.v1.rds")
DMAP.v1 <- "DMAP.v1 <- getScaffold('DMAP.v1')"
usethis::use_data(DMAP.v1, overwrite = TRUE)

# projectSample(DMAP.v1,ilaria_counts,ilaria_pData,"cancer_type", title = "DMAP")
