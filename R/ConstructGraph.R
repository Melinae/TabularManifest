##' @name construct_graph
##' @aliases construct_graph_univariate  construct_graph_list_univariate
##' @export construct_graph_univariate construct_graph_list_univariate
##' 
##' @title Construct a graph or list of graphs
##' 
##' @description Construct a graph or list of graphs, whose characteristics are determined by a configuration file.
##' 
##' @param variableName The name of the single variable to graph.
##' @param ds_metadata The \code{data.frame} containing the metadata. See \code{\link{CreateManifestExploreUnivariate}}.
##' @param dsObserved The \code{data.frame} containing the data to be graphed.
##' 
##' @examples
##' #dsObserved <- beaver1
##' dsObserved <- InsectSprays
##' ds_manifest <- TabularManifest::CreateManifestExploreUnivariate(dsObserved, writeToDisk=FALSE)
##'
##' construct_graph_univariate(variableName="count", ds_manifest, InsectSprays)
##' 
##' construct_graph_list_univariate(ds_manifest=ds_manifest, dsObserved=dsObserved)

construct_graph_univariate <- function( variableName, ds_metadata, dsObserved ) {
  ds_for_variable <- ds_metadata[ds_metadata$variableName==variableName, ]
  variableName <- ds_for_variable$variableName
  shouldGraph <- ds_for_variable$shouldGraph
  remark <- ds_for_variable$remark
  graphing_fx <- get(ds_for_variable$graphFunction)
  x_label_fx <- .get_with_package(ds_for_variable$xLabelFormat)
  
  binWidth <- ds_for_variable$binWidth
  if( shouldGraph ) 
    g <- graphing_fx(dsObserved=dsObserved, variableName=variableName, binWidth=binWidth)
  else
    g <- NULL
  
  return(list(variableName=variableName, graph=g, remark=remark))
}

construct_graph_list_univariate <- function( ds_manifest, dsObserved ) {
  graph_list <- lapply(X=ds_manifest$variableName, FUN=construct_graph_univariate, ds_metadata=ds_manifest, dsObserved=dsObserved)
  return( graph_list )
}

.get_with_package <- function( qualified_function ) {
  #TODO: write regex so that it accommodates a period in the variable name.
  #   if( !grepl("^(\\w+)::(\\w+)$", qualified_function, perl=TRUE) )
  #     stop("The function name should be qualified with it's package. For instance, pass `scales::comma` instead of simply `comma`.")
  split_function <- strsplit(qualified_function, split="::")[[1]]
  fx <- getExportedValue(split_function[1], split_function[2])
  return( fx )
}


# dsObserved <- beaver1
# dsObserved <- InsectSprays
# ds_manifest <- TabularManifest::CreateManifestExploreUnivariate(dsObserved, writeToDisk=FALSE)
# construct_graph_univariate(variableName="temp", ds_manifest, beaver1)
 
# graph_list <- lapply(X=ds_manifest$variableName, FUN=construct_graph_univariate, ds_metadata=ds_manifest, dsObserved=dsObserved)
# 
# construct_graph_list_univariate(ds_manifest=ds_manifest, dsObserved=dsObserved)
