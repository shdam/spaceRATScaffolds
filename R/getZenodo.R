#' Extract Zenodo information about a scaffold
#'
#' @param name Name of scaffold
#'
#' @return A data.frame with Zenodo location of scaffold
#' @noRd
#' @examples
#' zenodo <- getZenodo("DMAP")
getZenodo <- function(name){
    # Get info of scaffolds
    allScaffolds <- getAllScaffolds()

    if(length(name) > 1) stop(
        "Only one scaffold can be requested at a time. ",
        "The available are:\n",
        paste(allScaffolds$fullName, collapse=", "))

    # Remove "_scaffold" from name
    scaffoldName <- gsub("_scaffold", "", name)

    # Check name matches
    in_fullName <- all(scaffoldName %in% allScaffolds$fullName)
    in_name <- all(scaffoldName %in% allScaffolds$name)
    if(!(in_fullName | in_name)) stop(
        name, " is not an available scaffold. The available are:\n",
        paste(allScaffolds$fullName, collapse=", "))

    # Subset scaffolds
    if(in_fullName){
        zenodo <- allScaffolds[allScaffolds$fullName == scaffoldName, ]
    }else if(in_name) {
        zenodo <- allScaffolds[allScaffolds$name == scaffoldName,]
        # Get latest
        zenodo <- zenodo[zenodo$version == max(zenodo$version)]
    }

    return(zenodo)
}
