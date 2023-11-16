#' Helper function to get spaceRAT scaffolds
#' @importFrom zen4R download_zenodo
#' @importFrom utils data
#' @param name Name of scaffold to get
#' @param path Path to folder for storing scaffolds
#' @param timeout Setting download timeout
#' @export
getScaffold <- function(name, path = "scaffolds", timeout = 120){
    # Load the allScaffolds metadata
    utils::data("allScaffolds", package = "spaceRATScaffolds")

    if(length(name) > 1) stop(
        "Only one scaffold can be requested at a time. ",
        "The available are:\n",
        paste(allScaffolds$fullName, collapse=", "))

    # Remove "_scaffold"
    scaffold_name <- gsub("_scaffold", "", name)

    # Check name matches
    in_fullName <- all(scaffold_name %in% allScaffolds$fullName)
    in_name <- all(scaffold_name %in% allScaffolds$name)
    if(!(in_fullName | in_name)) stop(
        name, " is not an available scaffold. The available are:\n",
        paste(allScaffolds$fullName, collapse=", "))

    # Subset scaffolds
    if(in_fullName){
        scaffold <- allScaffolds[allScaffolds$fullName == scaffold_name, ]
    }else if(in_name) {
        scaffold <- allScaffolds[allScaffolds$name == scaffold_name,]
        # Get latest
        scaffold <- scaffold[scaffold$version == max(scaffold$version)]
    }

    # Create dir
    message("Putting '", name,"' in folder '", path, "'")
    system2(c("mkdir", "-p", path))


    # If scaffold is already downloaded
    if (file.exists(file.path(path, scaffold$filename))){
        scaffold <- readRDS(file.path(path, scaffold$filename))
        return(scaffold)
    }

    # Download scaffold
    zen4R::download_zenodo(
        doi = scaffold$doi,
        files = scaffold$filename,
        path = path,
        timeout = timeout)

    scaffold <- readRDS(file.path(path, scaffold$filename))
    return(scaffold)
}

