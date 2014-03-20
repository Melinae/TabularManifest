##' @name calculate_rounding_digits
##' 
##' @title Internal function for calculating rounding digits for dataset variables
##' 
##' @description An internal function (ie, that's not currently exposed/exported outside the package) for creating default bins for dataset variables.
##' 
##' @param ds_observed The \code{data.frame} with columns to calculate bins.

##' @return Returns a \code{numeric} vector, indicating how many rounding digits *might* be appropriate.
##'   Each element is an array with as many values as columns in \code{ds_observed}.
##' @examples
##' TabularManifest:::calculate_rounding_digits(ds_observed=freeny)
##' TabularManifest:::calculate_rounding_digits(ds_observed=InsectSprays)
##' TabularManifest:::calculate_rounding_digits(ds_observed=beaver1)

calculate_rounding_digits <- function( ds_observed ) {
  columnClass <- base::sapply(X=ds_observed, FUN=base::class)
  is_continuous <- (columnClass  %in% c("numeric", "integer"))
  
  #TODO: mapply might be more memory efficient.  An entire data.frame is recreated (minus the non-contintuous variables).  
  digits <- base::sapply(ds_observed[,is_continuous, drop=FALSE], FUN=function( x ){1 - log10(scales:::precision(x))})
  
  digits_all <- rep(x=1L, times=ncol(ds_observed))
  digits_all[is_continuous] <- max(0L, digits)
  
  return( digits_all )
}

# calculate_rounding_digits(ds_observed=freeny)
# calculate_rounding_digits(ds_observed=InsectSprays)
# calculate_rounding_digits(ds_observed=beaver1)
