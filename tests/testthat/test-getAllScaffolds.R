test_that("getAllScaffolds works", {
  allScaffolds <- getAllScaffolds()
  expect_s3_class(allScaffolds, "data.frame")
})
