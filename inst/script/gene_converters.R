
load(system.file("extdata/gene_id_converter_mm.rda", package = "spaceRATScaffolds"))
load(system.file("extdata/gene_id_converter_hs.rda", package = "spaceRATScaffolds"))

usethis::use_data(gene_id_converter_mm, overwrite = TRUE)
usethis::use_data(gene_id_converter_hs, overwrite = TRUE)
