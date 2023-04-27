# TCGA

library(spaceRAT)

tcga_counts_scaffold <- readr::read_csv("../spaceRAT_data/tcga_representativeSetLog2cpm.csv")
tcga_pheno_scaffold <- readr::read_csv("../spaceRAT_data/tcga_representativeSet_metadata.csv")

colname <- "study"#"tcga.gdc_cases.project.primary_site" # tcga.gdc_cases.project.name

TCGA_scaffold <- buildScaffold(
    object = tcga_counts_scaffold,
    pheno_scaffold = tcga_pheno_scaffold,
    colname = colname,
    data = "logged",
    dims = c(1,2),
    plot_mode = "dot",
    classes = NULL,
    pval_cutoff = 0.05,
    lfc_cutoff = 2,
    title = "TCGA PCA scaffold",
    pca_scale = FALSE,
    auto_plot = FALSE,
    annotation = "ensembl_gene"
)

usethis::use_data(TCGA_scaffold, overwrite = TRUE)


plotScaffold(TCGA_scaffold,"TCGA PCA scaffold")
