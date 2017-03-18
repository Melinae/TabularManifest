#' @name construct_graph
#' @aliases construct_graph_univariate  construct_graph_list_univariate
#' @export construct_graph_univariate construct_graph_list_univariate
#'
#' @title Construct a graph or list of graphs
#'
#' @description Construct a graph or list of graphs, whose characteristics are determined by a configuration file.
#'
#' @param variable_name The name of the single variable to graph.
#' @param ds_metadata The \code{data.frame} containing the metadata. See \code{\link{create_manifest_explore_univariate}}.
#' @param d_observed The \code{data.frame} containing the data to be graphed.
#'
#' @examples
#' #d_observed <- beaver1
#' d_observed <- InsectSprays
#' ds_manifest <- TabularManifest::create_manifest_explore_univariate(d_observed, write_to_disk=FALSE)
##'
#' construct_graph_univariate(variable_name="count", ds_manifest, InsectSprays)
#'
#' construct_graph_list_univariate(ds_manifest=ds_manifest, d_observed=d_observed)

construct_graph_univariate <- function( variable_name, ds_metadata, d_observed ) {
  ds_for_variable <- ds_metadata[ds_metadata$variable_name==variable_name, ]
  variable_name <- ds_for_variable$variable_name
  should_graph <- ds_for_variable$should_graph
  remark <- ds_for_variable$remark
  graphing_fx <- base::get(ds_for_variable$graph_function)
  x_label_fx <- .getWithPackage(ds_for_variable$x_label_format)

  bin_width <- ds_for_variable$bin_width
  if( should_graph )
    g <- graphing_fx(d_observed=d_observed, variable_name=variable_name, bin_width=bin_width)
  else
    g <- NULL

  return(list(variable_name=variable_name, graph=g, remark=remark))
}

construct_graph_list_univariate <- function( ds_manifest, d_observed ) {
  graph_list <- lapply(X=ds_manifest$variable_name, FUN=construct_graph_univariate, ds_metadata=ds_manifest, d_observed=d_observed)
  return( graph_list )
}

.getWithPackage <- function( qualified_function ) {
  #TODO: write regex so that it accommodates a period in the variable name.
  #   if( !grepl("^(\\w+)::(\\w+)$", qualified_function, perl=TRUE) )
  #     stop("The function name should be qualified with it's package. For instance, pass `scales::comma` instead of simply `comma`.")
  split_function <- base::strsplit(qualified_function, split="::")[[1]]
  fx <- base::getExportedValue(split_function[1], split_function[2])
  return( fx )
}


# d_observed <- beaver1
# d_observed <- InsectSprays
# ds_manifest <- TabularManifest::create_manifest_explore_univariate(d_observed, write_to_disk=FALSE)
# construct_graph_univariate(variable_name="temp", ds_manifest, beaver1)

# graph_list <- lapply(X=ds_manifest$variable_name, FUN=construct_graph_univariate, ds_metadata=ds_manifest, d_observed=d_observed)
#
# construct_graph_list_univariate(ds_manifest=ds_manifest, d_observed=d_observed)
