#' @name CreateManifestExploreUnivariate
#' @export
#' 
#' @title Create a manifest for exploratoring univariate patterns.
#' 
#' @description This function creates a meta-dataset (from the \code{data.frame} passed as a parameter) 
#' and optionally saves the meta-dataset as a CSV.  The meta-dataset specifies how the variables
#' should be plotted.
#' 
#' @usage
#' CreateManifestExploreUnivariate(
#'     ds_observed, 
#'     writeToDisk = TRUE,
#'     pathOut = getwd(), 
#'     overwriteFile = FALSE,
#'     defaultClassGraph = c(
#'       numeric = "HistogramContinuous", 
#'       integer = "HistogramContinuous", 
#'       factor = "HistogramDiscrete", 
#'       character = "HistogramDiscrete", 
#'       notMatched = "histogram_generic"
#'     ),
#'     defaultFormat = c(
#'       numeric = "scales::comma", 
#'       notMatched = "scales::comma"
#'     ),
#'     bin_count_suggestion = 30L
#' )
#' 
#' 
#' @param ds_observed The \code{data.frame} to create metadata for.
#' @param writeToDisk Indicates if the meta-dataset should be saved as a CSV.
#' @param pathOut The file path to save the meta-dataset.
#' @param overwriteFile Indicates if the CSV of the meta-dataset should be overwritten if a file already exists at the location.
#' @param defaultFormat A \code{character} array indicating which formatting function should be displayed on the axis of the univariate graph.
#' @param defaultClassGraph A \code{character} array indicating which graph should be used with variables of a certain class.
#' @param bin_count_suggestion An \code{integer} value of the number of roughly the number bins desired for a histogram.
#' 
#' @return Returns a \code{data.frame} where each row in the metadata represents a column in \code{ds_observed}.
#' The metadata contains the following columns
#' \enumerate{
#' \item{\code{variable_name} The variable name (in \code{ds_observed}). \code{character}.}
#' \item{\code{remark} A blank field that allows theuser to enter notes in the CSV for later reference.}
#' \item{\code{class} The variable's \code{\link{class}} (eg, numeric, Date, factor).  \code{character}.}
#' \item{\code{should_graph} A boolean value indicating if the variable should be graphed. \code{logical}.}
#' \item{\code{graph_function} The name of the function used to graph the variable. \code{character}.}
#' \item{\code{x_label_format} The name of the function used to format the \emph{x}-axis. \code{character}.}
#' \item{\code{bin_width} The uniform width of the bins. \code{numeric}.}
#' \item{\code{bin_start} The location of the left boundary of the first bin. \code{numeric}.}
#' }
#' @keywords explore
#' @examples
#' 
#' CreateManifestExploreUnivariate(datasets::InsectSprays, writeToDisk=FALSE)
#' 
#' #Careful, the first column is a `ts` class.
#' CreateManifestExploreUnivariate(datasets::freeny, writeToDisk=FALSE)  

CreateManifestExploreUnivariate <- function( 
  ds_observed, 
  writeToDisk = TRUE, 
  pathOut = getwd(), 
  overwriteFile = FALSE,
  defaultClassGraph = c(
    "numeric" = "HistogramContinuous",
    "integer" = "HistogramContinuous",
    "factor" = "HistogramDiscrete",
    "character" = "HistogramDiscrete",
    "notMatched" = "histogram_generic"
    ),
  defaultFormat = c(
    "numeric" = "scales::comma",
    "notMatched" = "scales::comma"
    ),
  bin_count_suggestion = 30L
  ) {
  
  #Determine the variable's class (eg, numeric, integer, factor, ...).
  column_class <- sapply(X=ds_observed, FUN=class)
  
  #Determine the index of the most appropriate graph.
  matchedIndexGraph <- match(column_class, names(defaultClassGraph))
  matchedIndexGraph <- ifelse(!is.na(matchedIndexGraph), matchedIndexGraph, which(names(defaultClassGraph)=="notMatched"))
 
  #Determine the index of the most appropriate format.
  matchedIndexFormat <- match(column_class, names(defaultFormat))
  matchedIndexFormat <- ifelse(!is.na(matchedIndexFormat), matchedIndexFormat, which(names(defaultFormat)=="notMatched"))
  
  bins <- calculate_bins(ds_observed, bin_count_suggestion=bin_count_suggestion)
  rounding_digits <- calculate_rounding_digits(ds_observed)
  
  #Create the data.frame of metadata.
  ds_skeleton <- data.frame(
    variable_name = colnames(ds_observed), 
    remark = "", 
    class = column_class,
    should_graph = TRUE, 
    graph_function = defaultClassGraph[matchedIndexGraph], 
    x_label_format = defaultFormat[matchedIndexFormat],
    bin_width = bins$bin_width,
    bin_start = bins$bin_start,
    rounding_digits = rounding_digits,
    stringsAsFactors = FALSE
  )

  #Ths sapply function sets rownames for the dataset.  They're redundant with the `variable_name` column.
  row.names(ds_skeleton) <- NULL 
  
  #If desired, write the data.frame to disk as a CSV.
  if( writeToDisk ) {
    if( overwriteFile & base::file.exists(pathOut) ) stop(paste0("The file `", pathOut, "` already exists, and will not be overwritten by `create_manifest_explore()`."))

    write.csv(x = ds_skeleton, 
              file = pathOut, 
              row.names = FALSE)  
  }
  
  return( ds_skeleton )
}

# ds <- CreateManifestExploreUnivariate(datasets::freeny, writeToDisk=FALSE) #Careful, the first column is a `ts` class.
# ds <- CreateManifestExploreUnivariate(datasets::InsectSprays, writeToDisk=FALSE)
# ds <- CreateManifestExploreUnivariate(datasets::beaver1, writeToDisk=FALSE)
# ds
