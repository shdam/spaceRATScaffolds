#' List available scaffolds
#' @return A list of scaffold names
#' @usage listScaffolds()
#' @importFrom utils data
#' @examples
#' listScaffolds()
#' @export
listScaffolds <- function(){
    data_list <- as.character(
        utils::data(package = "spaceRATScaffolds")$results[,"Item"])
    data_list[grepl("scaffold", data_list)]
}

#' List available datasets
#' @return A list of datasets names
#' @usage listDatasets()
#' @importFrom utils data
#' @examples
#' listDatasets()
#' @export
listDatasets <- function(){
    data_list <- as.character(
        utils::data(package = "spaceRATScaffolds")$results[,"Item"])
    data_list[grepl("exprs", data_list) | grepl("pData", data_list)]
}

#' List available ID converters
#' @return A list of ID converters names
#' @usage listConverters()
#' @importFrom utils data
#' @examples
#' listConverters()
#' @export
listConverters <- function(){
    data_list <- as.character(
        utils::data(package = "spaceRATScaffolds")$results[,"Item"])
    data_list[grepl("converter", data_list)]
}
