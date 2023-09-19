
<!-- README.md is generated from README.Rmd. Please edit that file -->

## spaceRATScaffolds

This package contains scaffolds used for
[spaceRAT](https://github.com/XueningHe/spaceRAT). See the package
vignettes for instructions how to build and use the scaffolds.

## Installation

Install from GitHub

``` r
# Install using remotes
# install.packages("remotes")
remotes::install_github("shdam/spaceRATScaffolds", build_vignettes = TRUE)
```

## Usage

This is a data package. The current `spaceRAT` scaffolds include:

``` r

library("spaceRATScaffolds")

listScaffolds()
#> [1] "DMAP_scaffold"

listDatasets()
#> [1] "DMAP_exprs"    "DMAP_pData"    "ilaria_counts" "ilaria_pData"

listConverters()
#> [1] "gene_id_converter_hs" "gene_id_converter_mm"
```

## Report issues

If you have any issues or questions regarding the use of
`spaceRATScaffolds`, please do not hesitate to raise an issue on GitHub.
In this way, others may also benefit from the answers and discussions.
