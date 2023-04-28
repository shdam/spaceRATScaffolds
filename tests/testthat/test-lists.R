test_that("listScaffolds works", {
  expect_type(listScaffolds(), "character")
})

test_that("listDatasets works", {
    expect_type(listDatasets(), "character")
})

test_that("listConverters works", {
    expect_type(listConverters(), "character")
})
