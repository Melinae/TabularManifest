##' @name CreateManifestExploreUnivariate
##' @export
##' 
##' @title Create a manifest for exploratoring univariate patterns.
##' 
##' @description This function creates a meta-dataset (from the \code{data.frame} passed as a parameter) 
##' and optionally saves the meta-dataset as a CSV.  The meta-dataset specifies how the variables
##' should be plotted.
##' 
##' @usage
##' CreateManifestExploreUnivariate(
##'     dsObserved, 
##'     writeToDisk = TRUE,
##'     path_out = getwd(), 
##'     overwrite_file = FALSE,
##'     default_class_graph = c(
##'       numeric = "HistogramContinuous", 
##'       integer = "HistogramContinuous", 
##'       factor = "HistogramDiscrete", 
##'       character = "HistogramDiscrete", 
##'       notMatched = "histogram_generic"
##'     ),
##'     default_format = c(
##'       numeric = "scales::comma", 
##'       notMatched = "scales::comma"
##'     ),
##'     binCountSuggestion = 30L
##' )
##' 
##' 
##' @param dsObserved The \code{data.frame} to create metadata for.
##' @param writeToDisk Indicates if the meta-dataset should be saved as a CSV.
##' @param path_out The file path to save the meta-dataset.
##' @param overwrite_file Indicates if the CSV of the meta-dataset should be overwritten if a file already exists at the location.
##' @param default_format A \code{character} array indicating which formatting function should be displayed on the axis of the univariate graph.
##' @param default_class_graph A \code{character} array indicating which graph should be used with variables of a certain class.
##' @param binCountSuggestion An \code{integer} value of the number of roughly the number bins desired for a histogram.
##' 
##' @return Returns a \code{data.frame} where each row in the metadata represents a column in \code{dsObserved}.
##' The metadata contains the following columns
##' \enumerate{
##' \item{\code{variable_name} The variable name (in \code{dsObserved}). \code{character}.}
##' \item{\code{remark} A blank field that allows theuser to enter notes in the CSV for later reference.}
##' \item{\code{class} The variable's \code{\link{class}} (eg, numeric, Date, factor).  \code{character}.}
##' \item{\code{should_graph} A boolean value indicating if the variable should be graphed. \code{logical}.}
##' \item{\code{graph_function} The name of the function used to graph the variable. \code{character}.}
##' \item{\code{x_label_format} The name of the function used to format the \emph{x}-axis. \code{character}.}
##' \item{\code{bin_width} The uniform width of the bins. \code{numeric}.}
##' \item{\code{bin_start} The location of the left boundary of the first bin. \code{numeric}.}
##' }
##' @keywords explore
##' @examples
##' 
##' CreateManifestExploreUnivariate(datasets::InsectSprays, writeToDisk=FALSE)
##' 
##' #Careful, the first column is a `ts` class.
##' CreateManifestExploreUnivariate(datasets::freeny, writeToDisk=FALSE)  

CreateManifestExploreUnivariate <- function( 
  dsObserved, 
  writeToDisk = TRUE, 
  path_out = getwd(), 
  overwrite_file = FALSE,
  default_class_graph = c(
    "numeric" = "HistogramContinuous",
    "integer" = "HistogramContinuous",
    "factor" = "HistogramDiscrete",
    "character" = "HistogramDiscrete",
    "notMatched" = "histogram_generic"
    ),
  default_format = c(
    "numeric" = "scales::comma",
    "notMatched" = "scales::comma"
    ),
  binCountSuggestion = 30L
  ) {
  
  #Determine the variable's class (eg, numeric, integer, factor, ...).
  columnClass <- sapply(X=dsObserved, FUN=class)
  
  #Determine the index of the most appropriate graph.
  matchedIndexGraph <- match(columnClass, names(default_class_graph))
  matchedIndexGraph <- ifelse(!is.na(matchedIndexGraph), matchedIndexGraph, which(names(default_class_graph)=="notMatched"))
 
  #Determine the index of the most appropriate format.
  matchedIndexFormat <- match(columnClass, names(default_format))
  matchedIndexFormat <- ifelse(!is.na(matchedIndexFormat), matchedIndexFormat, which(names(default_format)=="notMatched"))
  
  bins <- TabularManifest:::CalculateBins(dsObserved, binCountSuggestion=binCountSuggestion)
  rounding_digits <- TabularManifest:::calculate_rounding_digits(dsObserved)
  
  #Create the data.frame of metadata.
  ds_skeleton <- data.frame(
    variable_name = colnames(dsObserved), 
    remark = "", 
    class = columnClass,
    should_graph = TRUE, 
    graph_function = default_class_graph[matchedIndexGraph], 
    x_label_format = default_format[matchedIndexFormat],
    bin_width = bins$bin_width,
    bin_start = bins$bin_start,
    rounding_digits = rounding_digits,
    stringsAsFactors = FALSE
  )

  #Ths sapply function sets rownames for the dataset.  They're redundant with the `variable_name` column.
  row.names(ds_skeleton) <- NULL 
  
  #If desired, write the data.frame to disk as a CSV.
  if( writeToDisk ) {
    if( overwrite_file & base::file.exists(path_out) ) stop(paste0("The file `", path_out, "` already exists, and will not be overwritten by `create_manifest_explore()`."))

    write.csv(x = ds_skeleton, 
              file = path_out, 
              row.names = FALSE)  
  }
  
  return( ds_skeleton )
}

# ds <- CreateManifestExploreUnivariate(datasets::freeny, writeToDisk=FALSE) #Careful, the first column is a `ts` class.
# ds <- CreateManifestExploreUnivariate(datasets::InsectSprays, writeToDisk=FALSE)
# ds <- CreateManifestExploreUnivariate(datasets::beaver1, writeToDisk=FALSE)
# ds
