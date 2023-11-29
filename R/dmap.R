#' @title Expression matrix for scaffold
#' @source Kindly offered by Frederik Otzen Bagger
#' @description  exprs_map records expression matrix of normal
#' hematopoietic cells. The data is measured by microarray.
#' @docType data
#' @usage data("DMAP_exprs", package = "spaceRATScaffolds")
#' @format a matrix
#' @return a matrix
#' @keywords datasets
"DMAP_exprs"

#' @title Phenotype data for scaffold
#' @source Kindly offered by Frederik Otzen Bagger
#' @description  pData_map records phenotype information
#' corresponding to DMAP_exprs
#' @docType data
#' @usage data("DMAP_pData", package = "spaceRATScaffolds")
#' @format a data frame
#' @return a data.frame
#' @keywords datasets
"DMAP_pData"

#' @title  DMAP scaffold version 1
#' @source Raw data available at:
#' \url{https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE24759}
#' @description Scaffold of normal hematopoietic cells.
#' The data was measured by microarray.
#' @docType data
#' @usage getScaffold("DMAP")
#' @format a spaceRAT scaffold
#' @return a spaceRAT scaffold
#' @keywords datasets
"DMAP.v1"
