#' @name UnivariateTrim
#' @export
#' 
#' @title Trim extreme quantiles from a variable.
#' 
#' @description Replaces extreme values with \code{NA} values.
#' 
#' @param scores A vector of values that \code{quantile()} can accept.
#' @param quantileLower The lower inclusive bound of values to retain.
#' @param quantileUpper The upper inclusive bound of values to retain.
#' 
#' @return Returns a vector of the same \code{class} as \code{scores}.
#' @examples
#' #Exclude the largest 5%
#' TabularManifest::UnivariateTrim(scores=datasets::beaver1$temp, 
#'   quantileLower=0, quantileUpper=.95) 
#' 
#' #Exclude the largest 5% and the smallest 5%
#' TabularManifest::UnivariateTrim(scores=datasets::beaver1$temp, 
#'   quantileLower=.05, quantileUpper=.95) 

UnivariateTrim <- function( scores, quantileLower=0, quantileUpper=1.0 ) {
  positions <- stats::quantile(scores, probs=c(quantileLower, quantileUpper), na.rm=TRUE)
  return( ifelse((positions[1]<=scores) & (scores<=positions[2]), scores, NA) )
}
