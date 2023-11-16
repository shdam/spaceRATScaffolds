#' Helper function to load package data
#' @importFrom utils data
#' @param name Name of object to load
#' @export
loadData <- function(name){
    # Allow adding scaffold without the _scaffold tag
    if(name %in% gsub("_scaffold", "", spaceRATScaffolds::listScaffolds()))
        name <- paste0(name, "_scaffold")
    utils::data(
        list = name,
        package = "spaceRATScaffolds",
        envir = environment()
    )
    return(get(name))
}
