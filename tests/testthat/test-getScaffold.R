test_that("getScaffold works", {
  dmap <- getScaffold("DMAP", store = FALSE)
  dmap <- getScaffold("DMAP.v1", store = TRUE)
  system2(c("rm", "-r", "scaffolds"))

  expect_setequal(names(dmap), c("label","DEgenes", "pca", "umap"))

})
