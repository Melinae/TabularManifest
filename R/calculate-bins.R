#' @name calculate_bins
#'
#' @title Internal function for creating default bins for dataset variables.
#'
#' @description An internal function (ie, that's not currently exposed/exported outside the package) for creating default bins for dataset variables.
#'
#' @param ds_observed The \code{data.frame} with columns to calculate bins.
#' @param bin_count_suggestion An \code{integer} or \code{numeric} value for the suggested number of bins for each variable.
#'
#' @return Returns a \code{list}, with two elements.  Each element is an array with as many values as columns in \code{ds_observed}.
#' \enumerate{
#' \item{\code{bin_width} The variable name (in \code{ds_observed}).}
#' \item{\code{bin_start} The variable's \code{\link{class}}. (eg, numeric, Date, factor)}
#' }
#' @examples
#' #calculate_bins(ds_observed=datasets::freeny)
#' #calculate_bins(ds_observed=datasets::InsectSprays)

calculate_bins <- function( ds_observed, bin_count_suggestion=30L ) {
  column_class <- base::sapply(X=ds_observed, FUN=base::class)
  is_continuous <- (column_class %in% c("numeric", "integer"))

  #TODO: mapply might be more memory efficient.  An entire data.frame is recreated (minus the non-contintuous variables).
  bin_breaks <- base::lapply(X=ds_observed[,is_continuous, drop=FALSE], FUN=pretty, n=bin_count_suggestion) #, simplify=FALSE)
  bin_differences <- base::lapply(bin_breaks, diff)

  bin_width <- base::sapply(X=bin_differences   , FUN=stats::median   , na.rm=T)
  bin_start <- base::sapply(X=bin_breaks        , FUN=base::min       , na.rm=T)

  widths_all <- rep(x=1L, times=ncol(ds_observed))
  starts_all <- rep(x=1L, times=ncol(ds_observed))

  widths_all[is_continuous] <- bin_width
  starts_all[is_continuous] <- bin_start

  return( list(bin_width=widths_all, bin_start=starts_all) )
}

# calculate_bins(ds_observed=freeny)
# calculate_bins(ds_observed=InsectSprays)
