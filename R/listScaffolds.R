#' List available scaffolds
#'
#' This function will check the prebuilt scaffolds available on Zendodo and
#' list them.
#' @return A list of scaffold names
#' @usage listScaffolds()
#' @importFrom utils data
#' @examples
#' listScaffolds()
#' @export
listScaffolds <- function(){
    return(getAllScaffolds()$fullName)
}

#' List available datasets
#'
#' This function will list the test datasets available in `spaceRATScaffolds`.
#' @return A list of datasets names
#' @usage listDatasets()
#' @importFrom utils data
#' @examples
#' listDatasets()
#' @export
listDatasets <- function(){
    data_list <- as.character(
        utils::data(package = "spaceRATScaffolds")$results[,"Item"])
    data_list[
        grepl("counts", data_list) |
        grepl("exprs", data_list) |
        grepl("pData", data_list)]
}

#' List available ID converters
#'
#' This function will list the gene ID converters available in
#' `spaceRATscaffolds`.
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
