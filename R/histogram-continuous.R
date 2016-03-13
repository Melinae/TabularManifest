#' @name histogram_continuous
#' @export
#'
#' @title Generate a Histogram for a \code{numeric} or \code{integer} variable.
#'
#' @description Generate a histogram for a \code{numeric} or \code{integer} variable.  This graph is intended to quickly provide
#' the researcher with a quick, yet thorough representation of the continuous variable.  The additional annotations may not
#' be desired for publication-quality plots.
#'
#' @param ds_observed The \code{data.frame} with the variable to graph.
#' @param variable_name The name of the variable to graph. \code{character}.
#' @param bin_width The width of the histogram bins. If NULL, the \code{ggplot2} default is used. \code{numeric}.
#' @param main_title The desired title on top of the graph.  Defaults to \code{variable_name}. If no title is desired, pass a value of \code{NULL}. \code{character}.
#' @param x_title The desired title on the \emph{x}-axis.  Defaults to the \code{variable_name} and the \code{bin_width}. If no axis title is desired, pass a value of \code{NULL}. \code{character}.
#' @param y_title The desired title on the \emph{y}-axis.  Defaults to ``Frequency''. If no axis title is desired, pass a value of \code{NULL}. \code{character}.
#' @param rounded_digits The number of decimals to show for the mean and median annotations. \code{character}.
#'
#' @return Returns a histogram as a \code{ggplot2} object.
#' @examples
#' library(datasets)
#' #Don't run graphs on a headless machine without any the basic graphics packages installed.
#' if( require(grDevices) ) {
#'   histogram_continuous(ds_observed=beaver1, variable_name="temp", bin_width=.1)
#' }

#TODO: switch the hadj if there's a negative skew (so the mean is on the left side of the median)
#TODO: display the number of plotted and the number of excluded/missing values.
##TODO: add option for facet variable.

histogram_continuous <- function(
  ds_observed,
  variable_name,
  bin_width = NULL,
  main_title = variable_name,
  x_title = paste0(variable_name, " (each bin is ", scales::comma(bin_width), " units wide)"),
  y_title = "Frequency",
  rounded_digits = 0L
  ) {

  ds_observed <- ds_observed[!base::is.na(ds_observed[, variable_name]), ]

  ds_mid_points <- base::data.frame(label=c("italic(X)[50]", "bar(italic(X))"), stringsAsFactors=FALSE)
  ds_mid_points$value <- c(stats::median(ds_observed[, variable_name]), base::mean(ds_observed[, variable_name]))
  ds_mid_points$value_rounded <- base::round(ds_mid_points$value, rounded_digits)

  g <- ggplot2::ggplot(ds_observed, ggplot2::aes_string(x=variable_name))
  g <- g + ggplot2::geom_histogram(binwidth=bin_width, position=ggplot2::position_identity(), fill="gray70", color="gray90", alpha=.7)
  g <- g + ggplot2::geom_vline(xintercept=ds_mid_points$value, color="gray30")
  g <- g + ggplot2::geom_text(data=ds_mid_points, ggplot2::aes_string(x="value", y=0, label="value_rounded"), color="tomato", hjust=c(1, 0), vjust=.5)
  g <- g + ggplot2::scale_x_continuous(labels=scales::comma_format())
  g <- g + ggplot2::scale_y_continuous(labels=scales::comma_format())
  g <- g + ggplot2::labs(title=main_title, x=x_title, y=y_title)
  
  g <- g + ggplot2::theme_light() +
    ggplot2::theme(axis.ticks.length = grid::unit(0, "cm"))

  ds_mid_points$top <- stats::quantile(ggplot2::ggplot_build(g)$panel$ranges[[1]]$y.range, .8)
  g <- g + ggplot2::geom_text(data=ds_mid_points, ggplot2::aes_string(x="value", y="top", label="label"), color="tomato", hjust=c(1, 0), parse=TRUE)
  return( g )
}
# ds_midpoints <- data.frame(Label=c("italic(X)[50]", "bar(italic(X))"), stringsAsFactors=F)
# ds_midpoints$Value <- c(median(ds_plot[, response_name], na.rm=TRUE), mean(ds_plot[, response_name], na.rm=TRUE))
# ds_midpoints$ValueRounded <- round(ds_midpoints$Value, rounded_digits)
#
# if( diff( ds_midpoints$Value) > 0) label_alignment <- c(1, 0) #The median is less than the mean
# else label_alignment <- c(0, 1) #The mean is less than the median
#
# g <- ggplot(ds_plot, aes_string(x=response_name))
# g <- g + geom_bar(stat="bin", binwidth=bin_width, fill="gray70", color=color )
# g <- g + geom_vline(xintercept=ds_midpoints$Value, color="gray30")
# g <- g + geom_text(data=ds_midpoints, aes(x=Value, y=0, label=ValueRounded), color="red", hjust=label_alignment, vjust=.5)
# g <- g + scale_x_continuous(labels=comma_format())
# g <- g + scale_y_continuous(labels=comma_format())
# g <- g + labs(title=title, x=xLabel, y=yLabel)
# g <- g + ggplot2::theme_light()
# ds_midpoints$Top <- quantile(ggplot_build(g)$panel$ranges[[1]]$y.range, .8)
# g <- g + geom_text(data=ds_midpoints, aes(x=Value, y=Top, label=Label), color="red", hjust=label_alignment, parse=T)
# return( g )

# histogram_continuous(ds_observed=beaver1, variable_name="temp", bin_width=.1)
