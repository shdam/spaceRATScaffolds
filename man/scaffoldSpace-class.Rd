% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scaffoldSpace-class.R
\docType{class}
\name{scaffoldSpace-class}
\alias{scaffoldSpace-class}
\title{An S4 class to store all the information of scaffold space}
\description{
An S4 class to store all the information of scaffold space
}
\section{Slots}{

\describe{
\item{\code{DEgene}}{a character vector containing names of
differentially expressed genes in scaffold dataset}

\item{\code{label}}{a character vector containing labels of each data point}

\item{\code{model}}{a model returned by dimension reduction algorithm.
PCA algorithm should return an "prcomp" object. UMAP algorithm should
return a matrix.}

\item{\code{dims}}{the two indices of reduced dimensions to be plot}

\item{\code{plot_mode}}{a character indicating whether to add tiny label at
each data point. Options are "dot" or "tiny_label"}
}}

\examples{
utils::data("DMAP_scaffold", package = "spaceRATScaffolds")
space <- methods::new("scaffoldSpace",
    DEgene = methods::slot(DMAP_scaffold, "DEgene"),
    label = methods::slot(DMAP_scaffold, "label"),
    model = methods::slot(DMAP_scaffold, "model"),
    dims = methods::slot(DMAP_scaffold, "dims"),
    plot_mode =  methods::slot(DMAP_scaffold, "plot_mode"))
}
