#' @title Expression matrix for scaffold
#' @source https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE24759
#' @description  exprs_map records expression matrix of normal
#' hematopoietic cells. The data is measured by microarray.
#' @docType data
#' @usage data("DMAP_exprs", package = "spaceRATScaffolds")
#' @format a matrix
#' @return a matrix
#' @keywords datasets
"DMAP_exprs"

#' @title Phenotype data for scaffold
#' @source https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE24759
#' @description  pData_map records phenotype information
#' corresponding to DMAP_exprs
#' @docType data
#' @usage data("DMAP_pData", package = "spaceRATScaffolds")
#' @format a data frame
#' @return a data.frame
#' @keywords datasets
"DMAP_pData"

#' @title  DMAP scaffold Version 1
#' @source Created from \code{\link{DMAP_exprs}} and \code{\link{DMAP_pData}}
#' using \code{\link{spaceRAT::buildScaffold}}
#' @description This scaffold was build from the
#' \code{\link{DMAP_exprs}}and \code{\link{DMAP_pData}}
#' using \code{\link{spaceRAT::buildScaffold}}.
#' @docType data
#' @usage spaceRATScaffolds::loadData("DMAP")
#' @format a scaffoldSpace list
#' @return a scaffoldSpace list
#' @keywords datasets
"DMAP.v1_scaffold"
