#' Helper function to get spaceRAT scaffolds
#' @importFrom zen4R download_zenodo
#' @importFrom utils data
#' @param name Name of scaffold to get
#' @param store Whether or not to store the scaffold for future use
#' @param path Path to folder for storing scaffolds
#' @param timeout Setting download timeout
#' @examples
#' scaffold <- getScaffold("DMAP")
#' @return A spaceRAT scaffold
#' @export
getScaffold <- function(
    name,
    store = TRUE,
    path = "scaffolds",
    timeout = 120){

    # Extract zenodo location
    zenodo <- getZenodo(name)

    # If scaffold is already downloaded
    if (file.exists(file.path(path, zenodo$filename))){
        scaffold <- readRDS(file.path(path, zenodo$filename))
        return(scaffold)
    }
    if(store){
        # Create dir
        message("Putting '", name,"' in folder '", path, "'")
        system2(c("mkdir", "-p", path))
    } else{
        path <- "./"
        message("Scaffold will be removed after download.")
        }

    # Download scaffold
    zen4R::download_zenodo(
        doi = zenodo$doi,
        files = zenodo$filename,
        path = path,
        quiet = store,
        timeout = timeout)

    scaffold <- readRDS(file.path(path, zenodo$filename))
    if(!store) system2(c("rm", zenodo$filename)); message("Scaffold deleted.")
    return(scaffold)
}

#' Extract Zenodo information about a scaffold
#'
#' @param scaffoldName Name of scaffold
#'
#' @return A data.frame with Zenodo location of scaffold
#'
#' @examples
#' zenodo <- getZenodo("DMAP")
getZenodo <- function(scaffoldName){
    # Get info of scaffolds
    allScaffolds <- getAllScaffolds()

    if(length(scaffoldName) > 1) stop(
        "Only one scaffold can be requested at a time. ",
        "The available are:\n",
        paste(allScaffolds$fullName, collapse=", "))

    # Remove "_scaffold" from name
    scaffoldName <- gsub("_scaffold", "", scaffoldName)

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
