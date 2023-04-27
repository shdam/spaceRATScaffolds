#' List available scaffolds
#' @return A list of scaffold names
#' @usage listScaffolds()
#' @examples
#' listScaffolds()
#' @export
listScaffolds <- function(){
    data_list <- as.character(data(package = "spaceRATScaffolds")$results[,"Item"])
    data_list[grepl("scaffold", data_list)]
}

#' List available datasets
#' @return A list of datasets names
#' @usage listDatasets()
#' @examples
#' listDatasets()
#' @export
listDatasets <- function(){
    data_list <- as.character(data(package = "spaceRATScaffolds")$results[,"Item"])
    data_list[grepl("exprs", data_list) | grepl("pData", data_list)]
}

#' List available ID converters
#' @return A list of ID converters names
#' @usage listConverters()
#' @examples
#' listConverters()
#' @export
listConverters <- function(){
    data_list <- as.character(data(package = "spaceRATScaffolds")$results[,"Item"])
    data_list[grepl("converter", data_list)]
}
