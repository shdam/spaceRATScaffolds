#' Helper function to load package data
#' @importFrom utils data
#' @export
loadData <- function(name){
    utils::data(
        list = name,
        package = "spaceRATScaffolds",
        envir = environment()
    )
    return(get(name))
}

