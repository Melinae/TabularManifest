##' @name CalculateRoundingDigits
##' 
##' @title Internal function for calculating rounding digits for dataset variables
##' 
##' @description An internal function (ie, that's not currently exposed/exported outside the package) for creating default bins for dataset variables.
##' 
##' @param dsObserved The \code{data.frame} with columns to calculate bins.

##' @return Returns a \code{numeric} vector, indicating how many rounding digits *might* be appropriate.
##'   Each element is an array with as many values as columns in \code{dsObserved}.
##' @examples
##' CalculateRoundingDigits(dsObserved=freeny)
##' CalculateRoundingDigits(dsObserved=InsectSprays)
##' CalculateRoundingDigits(dsObserved=beaver1)

##' @export

CalculateRoundingDigits <- function( dsObserved ) {
  columnClass <- base::sapply(X=dsObserved, FUN=base::class)
  is_continuous <- (columnClass  %in% c("numeric", "integer"))
  
  #TODO: mapply might be more memory efficient.  An entire data.frame is recreated (minus the non-contintuous variables).  
  digits <- base::sapply(dsObserved[,is_continuous, drop=FALSE], FUN=function( x ){1 - log10(scales:::precision(x))})
  
  digits_all <- rep(x=1L, times=ncol(dsObserved))
  digits_all[is_continuous] <- max(0L, digits)
  
  return( digits_all )
}

# CalculateRoundingDigits(dsObserved=freeny)
# CalculateRoundingDigits(dsObserved=InsectSprays)
# CalculateRoundingDigits(dsObserved=beaver1)
