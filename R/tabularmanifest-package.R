#' @title Tabular Manifest
#' 
#' @description 
#' Our consulting company, \href{http://www.insightresults.com/}{Insight Results}, frequently assists clients with large datasets 
#' consisting of many variables of varying quality.  Before we can develop sophisticated statistical models to provide our 
#' client with insight and a competitive advantage, we first learn the characteristics of their existing datasets.  
#' This package provides tools that assist our initial exploration of real-world datasets.  Although these tools are not 
#' a substitute of thoughtful inspection in our later analyses, these make the exploration more time efficient.  These tools 
#' allow us to more quickly start developing innovative solutions and delivering results.
#' 
#' The idea behind this package is that \emph{configuring} metadata is quicker and more robust than \emph{coding} the same repetitive code. 
#' [We need to write more as the package takes shape.]
#' 
#' Thanks, the Insight Results Analytics Team
#' 
#' @docType package
#' @name tabularmanifest-package
#' @aliases tabularmanifest
#' @note 
#' Our company has benefited from many tools developed by the community, and we'd like to contribute back.  
#' Suggestions, criticisms, and code contributions are welcome.  If any developer is interested in trying a direction 
#' that suits them better, we'll be happy to explain the package's internals and help you fork your own version.  We have 
#' some starting material described in the \code{./documentation_for_developers/} directory.  The repository is currently
#' hosted at our \href{http://git.insightresults.com/gitlab/internal/tabularmanifest/tree/master}{GitLab} server.
#' 
#' If your organization is interested in the services of Insight Results, please contact 
#' \href{http://www.insightresults.com/derek-gominger}{Derek Gominger} at [what material belongs here]?  
#' 
#' [Is there anything else someone would like to include?]
#' 
#' #TODO: this line needs to be adapated when we move to GitHub.  For those interested in use the development version of 
#' `tabularmanifest`, run 
#' 
#' \code{devtools::install_github(repo="insightresults/tabularmanifest")}
#' 
#' @author 
#'  \href{http://scholar.google.com/citations?user=ffsJTC0AAAAJ}{William Howard Beasley}
#'   
#'  \href{http://www.insightresults.com/martin-lenardon}{Martin Lenardon}
#'  
#'  Jonathan Adler
#'  
#'  Chad Scherrer
#'  
#'  Dave Childers
#' 
#' Maintainer: Will Beasley <wibeasley@@hotmail.com>
#' 
#' @references [Do any article or book references make sense?  Maybe reproducible research?]
#' @keywords package
#' @examples
#' 
##' create_manifest_explore_univariate(datasets::InsectSprays, write_to_disk=FALSE)
##' 
##' if( require(grDevices) ) {
##'   histogram_continuous(ds_observed=beaver1, variable_name="temp", bin_width=.1)
##'   histogram_discrete(ds_observed=infert, variable_name="age")
##' }
NULL
