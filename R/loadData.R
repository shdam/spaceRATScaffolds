#' Helper function to load package data
#' @importFrom utils data
#' @examples
#' testData <- loadData("DMAP_exprs")
#' @return a spaceRATScaffolds data object
#' @export
loadData <- function(name){
    utils::data(
        list = name,
        package = "spaceRATScaffolds",
        envir = environment()
    )
    return(get(name))
}

