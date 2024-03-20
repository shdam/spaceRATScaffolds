
<!-- README.md is generated from README.Rmd. Please edit that file -->

## spaceRATScaffolds

This package contains scaffolds used for
[spaceRAT](https://github.com/shdam/spaceRAT). See the package vignettes
for instructions how to build and use the scaffolds.

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
#> [1] "TCGA.v2" "DMAP.v1" "GTEx.v1" "TCGA.v1"

listDatasets()
#> [1] "DMAP_exprs"    "DMAP_pData"    "ilaria_counts" "ilaria_pData"

listConverters()
#> [1] "gene_id_converter_hs" "gene_id_converter_mm"
```

### Get scaffold

``` r
scaffold <- getScaffold("DMAP")

# Add versioning to get a specific version:
scaffold.v1 <- getScaffold("DMAP.v1", store = TRUE, path = "scaffolds")
```

If you set `store = TRUE`, the scaffold will be stored locally in the
folder set by `path`. When re-acquiring the scaffold,
`getScaffold("DMAP.v1", path = "scaffolds")` will load the local
scaffold instead of downloading from Zenodo.

<!-- 
### Get scaffolds with SciDataFlow 

The scaffolds are managed with 
[SciDataFlow](https://github.com/vsbuffalo/scidataflow). 
If you have it installed, you can download all scaffolds with
`sdf pull` after cloning the repository.  

This will put the scaffolds in `inst/extdata`. 
Therefore, set `path = "inst/extdata"` when loading the scaffold 
with `getScaffold()`. 
-->

### Load test data

``` r

# Load test data 
testData <- loadData("DMAP_exprs")
testPheno <- loadData("DMAP_pData")
```

### Using spaceRAT

See [spaceRAT](https://github.com/shdam/spaceRAT) for instructions on
how to use the scaffolds.

## Report issues

If you have any issues or questions regarding the use of
`spaceRATScaffolds`, please do not hesitate to raise an issue on GitHub.
In this way, others may also benefit from the answers and discussions.
