#' @name create_manifest_explore_univariate
#' @export
#'
#' @title Create a manifest for exploring univariate patterns.
#'
#' @description This function creates a meta-dataset (from the \code{data.frame} passed as a parameter)
#' and optionally saves the meta-dataset as a CSV.  The meta-dataset specifies how the variables
#' should be plotted.
#'
#'
#' @param d_observed The \code{data.frame} to create metadata for.
#' @param write_to_disk Indicates if the meta-dataset should be saved as a CSV.
#' @param path_out The file path to save the meta-dataset.
#' @param overwrite_file Indicates if the CSV of the meta-dataset should be overwritten if a file already exists at the location.
#' @param default_format A \code{character} array indicating which formatting function should be displayed on the axis of the univariate graph.
#' @param default_class_graph A \code{character} array indicating which graph should be used with variables of a certain class.
#' @param bin_count_suggestion An \code{integer} value of the number of roughly the number bins desired for a histogram.
#'
#' @return Returns a \code{data.frame} where each row in the metadata represents a column in \code{d_observed}.
#' The metadata contains the following columns
#' \enumerate{
#' \item{\code{variable_name} The variable name (in \code{d_observed}). \code{character}.}
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
#' create_manifest_explore_univariate(datasets::InsectSprays, write_to_disk=FALSE)
#'
#' #Careful, the first column is a `ts` class.
#' create_manifest_explore_univariate(datasets::freeny, write_to_disk=FALSE)

create_manifest_explore_univariate <- function(
  d_observed,
  write_to_disk         = TRUE,
  path_out              = getwd(),
  overwrite_file        = FALSE,
  default_class_graph   = c(
    "numeric"                  = "histogram_continuous",
    "integer"                  = "histogram_continuous",
    "factor"                   = "histogram_discrete",
    "character"                = "histogram_discrete",
    "notMatched"               = "histogram_generic"
    ),
  default_format        = c(
    "numeric"                  = "scales::comma",
    "notMatched"               = "scales::comma"
    ),
  bin_count_suggestion  = 30L
  ) {

  #Determine the variable's class (eg, numeric, integer, factor, ...).
  column_class <- sapply(X=d_observed, FUN=class)

  #Determine the index of the most appropriate graph.
  matched_index_graph  <- match(column_class, names(default_class_graph))
  matched_index_graph  <- ifelse(!is.na(matched_index_graph), matched_index_graph, which(names(default_class_graph)=="notMatched"))

  #Determine the index of the most appropriate format.
  matched_index_format <- match(column_class, names(default_format))
  matched_index_format <- ifelse(!is.na(matched_index_format), matched_index_format, which(names(default_format)=="notMatched"))

  bins                 <- calculate_bins(d_observed, bin_count_suggestion=bin_count_suggestion)
  rounding_digits      <- calculate_rounding_digits(d_observed)

  #Create the data.frame of metadata.
  ds_skeleton <- data.frame(
    variable_name          = colnames(d_observed),
    remark                 = "",
    class                  = column_class,
    should_graph           = TRUE,
    graph_function         = default_class_graph[matched_index_graph],
    x_label_format         = default_format[matched_index_format],
    bin_width              = bins$bin_width,
    bin_start              = bins$bin_start,
    rounding_digits        = rounding_digits,
    stringsAsFactors       = FALSE
  )

  #Ths sapply function sets rownames for the dataset.  They're redundant with the `variable_name` column.
  row.names(ds_skeleton) <- NULL

  #If desired, write the data.frame to disk as a CSV.
  if( write_to_disk ) {
    if( overwrite_file & base::file.exists(path_out) ) {
      stop(paste0(
        "The file `", path_out, "` already exists, and will not be overwritten by `create_manifest_explore()`."
      ))
    }

    utils::write.csv(
      x         = ds_skeleton,
      file      = path_out,
      row.names = FALSE
    )
  }

  return( ds_skeleton )
}

# ds <- create_manifest_explore_univariate(datasets::freeny, write_to_disk=FALSE) #Careful, the first column is a `ts` class.
# ds <- create_manifest_explore_univariate(datasets::InsectSprays, write_to_disk=FALSE)
# ds <- create_manifest_explore_univariate(datasets::beaver1, write_to_disk=FALSE)
# ds
