#' @name HistogramDiscrete
#' @export
#' 
#' @title Generate a Histogram for a \code{character} or \code{factor} variable.
#' 
#' @description Generate a histogram for a \code{character} or \code{factor} variable.  This graph is intended to quickly provide
#' the researcher with a quick, yet thorough representation of the continuous variable.  The additional annotations may not
#' be desired for publication-quality plots.
#' 
#' @param dsObserved The \code{data.frame} with the variable to graph.
#' @param variableName The name of the variable to graph. \code{character}.
#' @param levelsToExclude An array of of the levels to be excluded from the histogram. Pass an empty variable (\emph{ie}, \code{character(0)}) if all levels are desired; this is the default. \code{character}.
#' @param mainTitle The desired title on top of the graph.  Defaults to \code{variableName}. If no title is desired, pass a value of \code{NULL}. \code{character}.
#' @param xTitle The desired title on the \emph{x}-axis.  Defaults to the number of included records. If no axis title is desired, pass a value of \code{NULL}. \code{character}.
#' @param yTitle The desired title on the \emph{y}-axis.  Defaults to ``Frequency''. If no axis title is desired, pass a value of \code{NULL}. \code{character}.
#' @param textSizePercentage The size of the percentage values on top of the bars. \code{character}.
#' @param binWidth (This parameter is included for compatibility with other graphing functions.  It should always be \code{1} for discrete and boolean variables.)
#' 
#' @return Returns a histogram as a \code{ggplot2} object. 
#' @examples
#' library(datasets)
#' #Don't run graphs on a headless machine without any the basic graphics packages installed.
#' if( require(grDevices) ) { 
#'   HistogramDiscrete(dsObserved=infert, variableName="education")
#'   HistogramDiscrete(dsObserved=infert, variableName="age")
#' }

##TODO: also include the number of missing & excluded records.  Possibly the excluded levels too.
##TODO: add option for facet variable.
##TODO: Add parameter for sorting
##TODO: add parameter for toggling between bars or points. create_manifest defaults to dots if they're more than 10 or 15 categories.  Otherwise it's a bar.

HistogramDiscrete <- function( 
  dsObserved, 
  variableName, 
  levelsToExclude = character(0), 
  mainTitle = variableName, 
  xTitle = NULL, 
  yTitle = "Number of Included Records", 
  textSizePercentage = 6,
  binWidth = 1L) {
  
  if( !base::is.factor(dsObserved[, variableName]) )
    dsObserved[, variableName] <- base::factor(dsObserved[, variableName])
  
  dsObserved$IV <- base::ordered(dsObserved[, variableName], levels=rev(levels(dsObserved[, variableName])))
  
  dsCount <- plyr::count(dsObserved, vars=c("IV"))
#   if( base::length(levelsToExclude)>0 ) {
  dsCount <- dsCount[!(dsCount$IV %in% levelsToExclude), ]
  
  dsSummary <- plyr::ddply(dsCount, .variables=NULL, transform, Count=freq, Proportion = freq/sum(freq) )
  dsSummary$Percentage <- base::paste0(base::round(dsSummary$Proportion*100), "%")
  
  yTitle <- base::paste0(yTitle, " (n=", scales::comma(base::sum(dsSummary$freq)), ")")
  
  g <- ggplot2::ggplot(dsSummary, ggplot2::aes_string(x="IV", y="Count", fill="IV", label="Percentage"))
  g <- g + ggplot2::geom_bar(stat="identity")
  g <- g + ggplot2::geom_text(stat="identity", size=textSizePercentage, hjust=.8)
  g <- g + ggplot2::scale_y_continuous(labels=scales::comma_format())
#   if( !base::is.null(palette) )
#     g <- g +  ggplot2::scale_fill_manual(values = base::rev(RColorBrewer::brewer.pal(base::nrow(dsSummary), palette)))
  g <- g + ggplot2::labs(title=mainTitle, x=xTitle, y=yTitle)
  g <- g + ggplot2::coord_flip()
  
  g <- g + ggplot2::theme_bw(base_size=14) 
  g <- g + ggplot2::theme(legend.position = "none") 
  g <- g + ggplot2::theme(axis.text.x=ggplot2::element_text(colour="gray40"))
  g <- g + ggplot2::theme(axis.title.x=ggplot2::element_text(colour="gray40"))
  g <- g + ggplot2::theme(axis.text.y=ggplot2::element_text(size=14))
  g <- g + ggplot2::theme(panel.border = ggplot2::element_rect(colour="gray80"))
  g <- g + ggplot2::theme(axis.ticks.length = grid::unit(0, "cm"))
  
  # g <- g + facet_grid(~AgeIntakeInYearsMaxPretty)
  return( g )
}

# HistogramDiscrete(dsObserved=infert, variableName="education")
# HistogramDiscrete(dsObserved=infert, variableName="age")
