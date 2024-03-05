#' Helper function to get spaceRAT scaffolds
#'
#' This function acquires a given prebuilt scaffold from the scaffolds
#' available on Zenodo. To prevent repeated downloads, `store` can be set to
#' `TRUE`. This will create a "scaffolds" folder, where the scaffolds are
#' stored.
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
    store = FALSE,
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

