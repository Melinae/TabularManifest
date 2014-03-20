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
##'     pathOut = getwd(), 
##'     overwriteFile = FALSE,
##'     defaultClassGraph = c(
##'       numeric = "HistogramContinuous", 
##'       integer = "HistogramContinuous", 
##'       factor = "HistogramDiscrete", 
##'       character = "HistogramDiscrete", 
##'       notMatched = "histogram_generic"
##'     ),
##'     defaultFormat = c(
##'       numeric = "scales::comma", 
##'       notMatched = "scales::comma"
##'     ),
##'     binCountSuggestion = 30L
##' )
##' 
##' 
##' @param dsObserved The \code{data.frame} to create metadata for.
##' @param writeToDisk Indicates if the meta-dataset should be saved as a CSV.
##' @param pathOut The file path to save the meta-dataset.
##' @param overwriteFile Indicates if the CSV of the meta-dataset should be overwritten if a file already exists at the location.
##' @param defaultFormat A \code{character} array indicating which formatting function should be displayed on the axis of the univariate graph.
##' @param defaultClassGraph A \code{character} array indicating which graph should be used with variables of a certain class.
##' @param binCountSuggestion An \code{integer} value of the number of roughly the number bins desired for a histogram.
##' 
##' @return Returns a \code{data.frame} where each row in the metadata represents a column in \code{dsObserved}.
##' The metadata contains the following columns
##' \enumerate{
##' \item{\code{variableName} The variable name (in \code{dsObserved}). \code{character}.}
##' \item{\code{remark} A blank field that allows theuser to enter notes in the CSV for later reference.}
##' \item{\code{class} The variable's \code{\link{class}} (eg, numeric, Date, factor).  \code{character}.}
##' \item{\code{shouldGraph} A boolean value indicating if the variable should be graphed. \code{logical}.}
##' \item{\code{graphFunction} The name of the function used to graph the variable. \code{character}.}
##' \item{\code{xLabelFormat} The name of the function used to format the \emph{x}-axis. \code{character}.}
##' \item{\code{binWidth} The uniform width of the bins. \code{numeric}.}
##' \item{\code{binStart} The location of the left boundary of the first bin. \code{numeric}.}
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
  binCountSuggestion = 30L
  ) {
  
  #Determine the variable's class (eg, numeric, integer, factor, ...).
  columnClass <- sapply(X=dsObserved, FUN=class)
  
  #Determine the index of the most appropriate graph.
  matchedIndexGraph <- match(columnClass, names(defaultClassGraph))
  matchedIndexGraph <- ifelse(!is.na(matchedIndexGraph), matchedIndexGraph, which(names(defaultClassGraph)=="notMatched"))
 
  #Determine the index of the most appropriate format.
  matchedIndexFormat <- match(columnClass, names(defaultFormat))
  matchedIndexFormat <- ifelse(!is.na(matchedIndexFormat), matchedIndexFormat, which(names(defaultFormat)=="notMatched"))
  
  bins <- TabularManifest:::CalculateBins(dsObserved, binCountSuggestion=binCountSuggestion)
  rounding_digits <- TabularManifest:::calculate_rounding_digits(dsObserved)
  
  #Create the data.frame of metadata.
  ds_skeleton <- data.frame(
    variableName = colnames(dsObserved), 
    remark = "", 
    class = columnClass,
    shouldGraph = TRUE, 
    graphFunction = defaultClassGraph[matchedIndexGraph], 
    xLabelFormat = defaultFormat[matchedIndexFormat],
    binWidth = bins$binWidth,
    binStart = bins$binStart,
    rounding_digits = rounding_digits,
    stringsAsFactors = FALSE
  )

  #Ths sapply function sets rownames for the dataset.  They're redundant with the `variableName` column.
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
