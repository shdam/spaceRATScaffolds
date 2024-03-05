#' Helper function to load package data
#'
#' This is a helper function that extracts a dataset in `spaceRATScaffolds`,
#' allowing the user to store the object in the name of their choice.
#' @importFrom utils data
#' @param name Name of object to load
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

