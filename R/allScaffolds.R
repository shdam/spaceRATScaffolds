#' Get data frame of all scaffolds uploaded to Zenodo
#'
#' @param doi The DOI of the Zenodo entry
#'
#' @importFrom zen4R get_zenodo
#' @return A data.frame of scaffolds
#' @export
#'
#' @examples
#' allScaffolds <- getAllScaffolds()
getAllScaffolds <- function(doi = "10.5281/zenodo.10142340"){
    zen <- zen4R::get_zenodo("10.5281/zenodo.10142340")
    allScaffolds <- do.call(rbind, lapply(zen$files, function(x) {
        data.frame(
            name = gsub("\\..*", "", x$filename),
            version = gsub(".*\\.v(.*)\\_.*", "\\1", x$filename),
            doi = doi,
            fullName = gsub("_scaffold\\.rds", "", x$filename),
            filename = x$filename,
            stringsAsFactors = FALSE
        )
    }))
    return(allScaffolds)
}
