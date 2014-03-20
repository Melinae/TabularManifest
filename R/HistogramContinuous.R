##' @name HistogramContinuous
##' @export
##' 
##' @title Generate a Histogram for a \code{numeric} or \code{integer} variable.
##' 
##' @description Generate a histogram for a \code{numeric} or \code{integer} variable.  This graph is intended to quickly provide
##' the researcher with a quick, yet thorough representation of the continuous variable.  The additional annotations may not
##' be desired for publication-quality plots.
##' 
##' @param dsObserved The \code{data.frame} with the variable to graph.
##' @param variableName The name of the variable to graph. \code{character}.
##' @param binWidth The width of the histogram bins. If NULL, the \code{ggplot2} default is used. \code{numeric}.
##' @param mainTitle The desired title on top of the graph.  Defaults to \code{variableName}. If no title is desired, pass a value of \code{NULL}. \code{character}.
##' @param xTitle The desired title on the \emph{x}-axis.  Defaults to the \code{variableName} and the \code{binWidth}. If no axis title is desired, pass a value of \code{NULL}. \code{character}.
##' @param yTitle The desired title on the \emph{y}-axis.  Defaults to ``Frequency''. If no axis title is desired, pass a value of \code{NULL}. \code{character}.
##' @param roundedDigits The number of decimals to show for the mean and median annotations. \code{character}.
##' 
##' @return Returns a histogram as a \code{ggplot2} object. 
##' @examples
##' library(datasets)
##' #Don't run graphs on a headless machine without any the basic graphics packages installed.
##' if( require(grDevices) ) { 
##'   HistogramContinuous(dsObserved=beaver1, variableName="temp", binWidth=.1)
##' }

#TODO: switch the hadj if there's a negative skew (so the mean is on the left side of the median)
#TODO: display the number of plotted and the number of excluded/missing values.
##TODO: add option for facet variable.

HistogramContinuous <- function( 
  dsObserved, 
  variableName, 
  binWidth = NULL, 
  mainTitle = variableName, 
  xTitle = paste0(variableName, " (each bin is ", scales::comma(binWidth), " units wide)"), 
  yTitle = "Frequency",
  roundedDigits = 0L
  ) {
  
  dsObserved <- dsObserved[!base::is.na(dsObserved[, variableName]), ]
  
  ds_mid_points <- base::data.frame(label=c("italic(X)[50]", "bar(italic(X))"), stringsAsFactors=FALSE)  
  ds_mid_points$value <- c(stats::median(dsObserved[, variableName]), base::mean(dsObserved[, variableName]))
  ds_mid_points$value_rounded <- base::round(ds_mid_points$value, roundedDigits)
  
  g <- ggplot2::ggplot(dsObserved, ggplot2::aes_string(x=variableName)) 
  g <- g + ggplot2::geom_bar(stat="bin", binwidth=binWidth, fill="gray70", color="gray90" )
  g <- g + ggplot2::geom_vline(xintercept=ds_mid_points$value, color="gray30")
  g <- g + ggplot2::geom_text(data=ds_mid_points, ggplot2::aes_string(x="value", y=0, label="value_rounded"), color="tomato", hjust=c(1, 0), vjust=.5)
  g <- g + ggplot2::scale_x_continuous(labels=scales::comma_format())
  g <- g + ggplot2::scale_y_continuous(labels=scales::comma_format())
  g <- g + ggplot2::labs(title=mainTitle, x=xTitle, y=yTitle)
  g <- g + ggplot2::theme_bw()
  
  ds_mid_points$top <- stats::quantile(ggplot2::ggplot_build(g)$panel$ranges[[1]]$y.range, .8)
  g <- g + ggplot2::geom_text(data=ds_mid_points, ggplot2::aes_string(x="value", y="top", label="label"), color="tomato", hjust=c(1, 0), parse=TRUE)
  return( g )  
}

# HistogramContinuous(dsObserved=beaver1, variableName="temp", binWidth=.1)
