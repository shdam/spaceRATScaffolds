#' @importFrom methods setClassUnion setOldClass
methods::setOldClass("prcomp")
methods::setClassUnion("model", c("prcomp", "matrix"))


#' An S4 class to store all the information of scaffold space
#' @slot DEgene a character vector containing names of
#' differentially expressed genes in scaffold dataset
#' @slot label a character vector containing labels of each data point
#' @slot model a model returned by dimension reduction algorithm.
#' PCA algorithm should return an "prcomp" object. UMAP algorithm should
#' return a matrix.
#' @slot dims the two indices of reduced dimensions to be plot
#' @slot plot_mode a character indicating whether to add tiny label at
#' each data point. Options are "dot" or "tiny_label"
#' @importFrom methods new setClass slot setClassUnion
#' @import stats
#' @export
#' @examples
#' utils::data("DMAP_scaffold", package = "spaceRATScaffolds")
#' space <- methods::new("scaffoldSpace",
#'     DEgene = methods::slot(DMAP_scaffold, "DEgene"),
#'     label = methods::slot(DMAP_scaffold, "label"),
#'     model = methods::slot(DMAP_scaffold, "model"),
#'     dims = methods::slot(DMAP_scaffold, "dims"),
#'     plot_mode =  methods::slot(DMAP_scaffold, "plot_mode"))
methods::setClass(
    "scaffoldSpace",
    slots = list(
        DEgene="character",
        label = "character",
        model = "model",
        dims = "numeric",
        plot_mode = "character"
    ),
    validity = function(object) {
        # Check if dims is of length 2
        if (length(slot(object, "dims")) != 2) {
            return("dims slot should have a length of 2.")
        }

        # Check if plot_mode has a valid value
        if (!(slot(object, "plot_mode") %in% c("dot", "tiny_label"))) {
            return("plot_mode slot should be either 'dot' or 'tiny_label'.")
        }

        return(TRUE)
    }
)
