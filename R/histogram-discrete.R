#' @name histogram_discrete
#' @export
#' @importFrom magrittr %>%
#'
#' @title Generate a Histogram for a \code{character} or \code{factor} variable.
#'
#' @description Generate a histogram for a \code{character} or \code{factor} variable.  This graph is intended to quickly provide
#' the researcher with a quick, yet thorough representation of the continuous variable.  The additional annotations may not
#' be desired for publication-quality plots.
#' 
#' 
#' @param ds_observed The \code{data.frame} with the variable to graph.
#' @param variable_name The name of the variable to graph. \code{character}.
#' @param levels_to_exclude An array of of the levels to be excluded from the histogram. Pass an empty variable (\emph{ie}, \code{character(0)}) if all levels are desired; this is the default. \code{character}.
#' @param main_title The desired title on top of the graph.  Defaults to \code{variable_name}, with underscores replaced with spaces. If no title is desired, pass a value of \code{NULL}. \code{character}.
#' @param x_title The desired title on the \emph{x}-axis.  Defaults to the number of included records. If no axis title is desired, pass a value of \code{NULL}. \code{character}.
#' @param y_title The desired title on the \emph{y}-axis.  Defaults to ``Frequency''. If no axis title is desired, pass a value of \code{NULL}. \code{character}.
#' @param text_size_percentage The size of the percentage values on top of the bars. \code{character}.
#' @param bin_width (This parameter is included for compatibility with other graphing functions.  It should always be \code{1} for discrete and boolean variables.)
#' @param font_base_size Sets font size through ggplot2's theme.
#'
#' @return Returns a histogram as a \code{ggplot2} object.
#' @examples
#' library(datasets)
#' #Don't run graphs on a headless machine without any the basic graphics packages installed.
#' if( require(grDevices) ) {
#'   histogram_discrete(ds_observed=infert, variable_name="education")
#'   histogram_discrete(ds_observed=infert, variable_name="age")
#' }

##TODO: also include the number of missing & excluded records.  Possibly the excluded levels too.
##TODO: add option for facet variable.
##TODO: Add parameter for sorting
##TODO: add parameter for toggling between bars or points. create_manifest defaults to dots if they're more than 10 or 15 categories.  Otherwise it's a bar.

histogram_discrete <- function(
  ds_observed,
  variable_name,
  levels_to_exclude       = character(0),
  main_title              = base::gsub("_", " ", variable_name, perl=TRUE),
  x_title                 = NULL,
  y_title                 = "Number of Included Records",
  text_size_percentage    = 6,
  bin_width               = 1L,
  font_base_size          = 12

) {

  if( !inherits(ds_observed, "data.frame") ) 
    stop("`ds_observed` should inherit from the data.frame class.")

  if( !base::is.factor(ds_observed[[variable_name]]) )
    ds_observed[[variable_name]] <- base::factor(ds_observed[[variable_name]])

  ds_observed$iv <- base::ordered(ds_observed[[variable_name]], levels=rev(levels(ds_observed[[variable_name]])))

  ds_observed <- ds_observed[!(ds_observed$iv %in% levels_to_exclude), ]

  d_summary <- ds_observed %>%
    dplyr::count_("iv") %>% 
    dplyr::mutate_(
      "count"             = "n",
      "proportion"        = "n / sum(n)",
      "percent_pretty"    = "base::paste0(base::round(proportion*100), '%')"
    )
  
  y_title <- base::paste0(y_title, " (n=", scales::comma(base::sum(d_summary$n)), ")")

  g <- ggplot2::ggplot(d_summary, ggplot2::aes_string(x="iv", y="count", fill="iv", label="percent_pretty"))
  g <- g + ggplot2::geom_bar(stat="identity", alpha=.4)
  g <- g + ggplot2::geom_text(stat="identity", size=text_size_percentage, hjust=.5)
  g <- g + ggplot2::scale_y_continuous(labels=scales::comma_format())
  # if( !base::is.null(palette) )
  #   g <- g +  ggplot2::scale_fill_manual(values = base::rev(RColorBrewer::brewer.pal(base::nrow(d_summary), palette)))
  g <- g + ggplot2::labs(title=main_title, x=x_title, y=y_title)
  g <- g + ggplot2::coord_flip()

  theme  <- ggplot2::theme_light(base_size = font_base_size) +
    ggplot2::theme(legend.position        = "none") +
    ggplot2::theme(panel.grid.major.y     = ggplot2::element_blank(), panel.grid.minor.y=ggplot2::element_blank()) +
    ggplot2::theme(axis.text.x            = ggplot2::element_text(colour="gray40")) +
    ggplot2::theme(axis.title.x           = ggplot2::element_text(colour="gray40")) +
    ggplot2::theme(axis.text.y            = ggplot2::element_text(size=14)) +
    ggplot2::theme(panel.border           = ggplot2::element_rect(colour="gray80")) +
    ggplot2::theme(axis.ticks             = ggplot2::element_blank())

  # g <- g + facet_grid(~AgeIntakeInYearsMaxPretty)
  return( g + theme )
}

# histogram_discrete(ds_observed=infert, variable_name="education")
# devtools::load_all()
# histogram_discrete(ds_observed=tibble::as_tibble(infert), variable_name="age")
