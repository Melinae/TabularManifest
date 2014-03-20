##' @name ConstructGraph
##' @aliases ConstructGraphUnivariate  ConstructGraphListUnivariate
##' @export ConstructGraphUnivariate ConstructGraphListUnivariate
##' 
##' @title Construct a graph or list of graphs
##' 
##' @description Construct a graph or list of graphs, whose characteristics are determined by a configuration file.
##' 
##' @param variableName The name of the single variable to graph.
##' @param dsMetadata The \code{data.frame} containing the metadata. See \code{\link{CreateManifestExploreUnivariate}}.
##' @param dsObserved The \code{data.frame} containing the data to be graphed.
##' 
##' @examples
##' #dsObserved <- beaver1
##' dsObserved <- InsectSprays
##' dsManifest <- TabularManifest::CreateManifestExploreUnivariate(dsObserved, writeToDisk=FALSE)
##'
##' ConstructGraphUnivariate(variableName="count", dsManifest, InsectSprays)
##' 
##' ConstructGraphListUnivariate(dsManifest=dsManifest, dsObserved=dsObserved)

ConstructGraphUnivariate <- function( variableName, dsMetadata, dsObserved ) {
  ds_for_variable <- dsMetadata[dsMetadata$variableName==variableName, ]
  variableName <- ds_for_variable$variableName
  shouldGraph <- ds_for_variable$shouldGraph
  remark <- ds_for_variable$remark
  graphing_fx <- get(ds_for_variable$graphFunction)
  x_label_fx <- .getWithPackage(ds_for_variable$xLabelFormat)
  
  binWidth <- ds_for_variable$binWidth
  if( shouldGraph ) 
    g <- graphing_fx(dsObserved=dsObserved, variableName=variableName, binWidth=binWidth)
  else
    g <- NULL
  
  return(list(variableName=variableName, graph=g, remark=remark))
}

ConstructGraphListUnivariate <- function( dsManifest, dsObserved ) {
  graph_list <- lapply(X=dsManifest$variableName, FUN=ConstructGraphUnivariate, dsMetadata=dsManifest, dsObserved=dsObserved)
  return( graph_list )
}

.getWithPackage <- function( qualifiedFunction ) {
  #TODO: write regex so that it accommodates a period in the variable name.
  #   if( !grepl("^(\\w+)::(\\w+)$", qualifiedFunction, perl=TRUE) )
  #     stop("The function name should be qualified with it's package. For instance, pass `scales::comma` instead of simply `comma`.")
  split_function <- strsplit(qualifiedFunction, split="::")[[1]]
  fx <- getExportedValue(split_function[1], split_function[2])
  return( fx )
}


# dsObserved <- beaver1
# dsObserved <- InsectSprays
# dsManifest <- TabularManifest::CreateManifestExploreUnivariate(dsObserved, writeToDisk=FALSE)
# ConstructGraphUnivariate(variableName="temp", dsManifest, beaver1)
 
# graph_list <- lapply(X=dsManifest$variableName, FUN=ConstructGraphUnivariate, dsMetadata=dsManifest, dsObserved=dsObserved)
# 
# ConstructGraphListUnivariate(dsManifest=dsManifest, dsObserved=dsObserved)
