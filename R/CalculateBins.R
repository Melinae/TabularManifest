#' @name CalculateBins
#' 
#' @title Internal function for creating default bins for dataset variables.
#' 
#' @description An internal function (ie, that's not currently exposed/exported outside the package) for creating default bins for dataset variables.
#' 
#' @param dsObserved The \code{data.frame} with columns to calculate bins.
#' @param binCountSuggestion An \code{integer} or \code{numeric} value for the suggested number of bins for each variable.
#' 
#' @return Returns a \code{list}, with two elements.  Each element is an array with as many values as columns in \code{dsObserved}.
#' \enumerate{
#' \item{\code{binWidth} The variable name (in \code{dsObserved}).}
#' \item{\code{binStart} The variable's \code{\link{class}}. (eg, numeric, Date, factor)}
#' }
#' @examples
#' #CalculateBins(dsObserved=datasets::freeny)
#' #CalculateBins(dsObserved=datasets::InsectSprays)

CalculateBins <- function( dsObserved, binCountSuggestion=30L ) {
  columnClass <- base::sapply(X=dsObserved, FUN=base::class)
  is_continuous <- (columnClass %in% c("numeric", "integer"))
  
  #TODO: mapply might be more memory efficient.  An entire data.frame is recreated (minus the non-contintuous variables).  
  bin_breaks <- base::lapply(X=dsObserved[,is_continuous, drop=FALSE], FUN=pretty, n=binCountSuggestion) #, simplify=FALSE)
  bin_differences <- base::lapply(bin_breaks, diff)  
  
  binWidth <- base::sapply(X=bin_differences, FUN=median, na.rm=T)
  binStart <- base::sapply(X=bin_breaks, FUN=min, na.rm=T)
  
  widths_all <- rep(x=1L, times=ncol(dsObserved))
  starts_all <- rep(x=1L, times=ncol(dsObserved))
  
  widths_all[is_continuous] <- binWidth
  starts_all[is_continuous] <- binStart
  
  return( list(binWidth=widths_all, binStart=starts_all) )
}

# CalculateBins(dsObserved=freeny)
# CalculateBins(dsObserved=InsectSprays)
