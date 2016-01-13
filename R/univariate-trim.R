#' @name univariate_trim
#' @export
#'
#' @title Trim extreme quantiles from a variable.
#'
#' @description Replaces extreme values with \code{NA} values.
#'
#' @param scores A vector of values that \code{quantile()} can accept.
#' @param quantile_lower The lower inclusive bound of values to retain.
#' @param quantile_upper The upper inclusive bound of values to retain.
#'
#' @return Returns a vector of the same \code{class} as \code{scores}.
#' @examples
#' #Exclude the largest 5%
#' TabularManifest::univariate_trim(scores=datasets::beaver1$temp,
#'   quantile_lower=0, quantile_upper=.95)
#'
#' #Exclude the largest 5% and the smallest 5%
#' TabularManifest::univariate_trim(scores=datasets::beaver1$temp,
#'   quantile_lower=.05, quantile_upper=.95)

univariate_trim <- function( scores, quantile_lower=0, quantile_upper=1.0 ) {
  positions <- stats::quantile(scores, probs=c(quantile_lower, quantile_upper), na.rm=TRUE)
  return( ifelse((positions[1]<=scores) & (scores<=positions[2]), scores, NA) )
}
