#' Get data frame of all scaffolds uploaded to Zenodo
#'
#' @param doi The DOI of the Zenodo entry
#'
#' @importFrom zen4R get_zenodo
#' @return A data.frame of scaffolds
#' @noRd
#'
#' @examples
#' allScaffolds <- getAllScaffolds()
getAllScaffolds <- function(doi = "10.5281/zenodo.16919084"){ # UPDATE ZENODO VERSION HERE
    zen <- zen4R::get_zenodo(doi)
    allScaffolds <- do.call(rbind, lapply(zen$files, function(x) {
        data.frame(
            name = gsub("\\..*", "", x$filename),
            version = gsub(".*\\.v(\\d*).*", "\\1", x$filename),
            doi = doi,
            fullName = gsub("(_scaffold)?\\.rds", "", x$filename),
            filename = x$filename,
            stringsAsFactors = FALSE
        )
    }))
    return(allScaffolds)
}
