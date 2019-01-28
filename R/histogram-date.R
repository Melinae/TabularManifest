#' @name histogram_date
#' @export
#' @importFrom magrittr %>%
#'
#' @title Generate a Histogram for a \code{date} variable.
#'
#' @description Generate a histogram for a \code{date} variable.  This graph is intended to quickly provide
#' the researcher with a quick, yet thorough representation of the date.  The additional annotations may not
#' be desired for publication-quality plots.
#'
#' @param d_observed The \code{data.frame} with the variable to graph.
#' @param variable_name The name of the variable to graph. \code{character}.
#' @param bin_unit The width of the histogram bins. Balue is passed to [base::seq.Date()]. Defaults to 'day'. \code{numeric}.
#' @param main_title The desired title on top of the graph.  Defaults to \code{variable_name}, with underscores replaced with spaces. If no title is desired, pass a value of \code{NULL}. \code{character}.
#' @param sub_title The desired subtitle near the top of the graph.  Defaults to \code{NULL} If no subtitle is desired, pass a value of \code{NULL}. \code{character}.
#' @param caption The desired text in the bottom-right, below the axis.  Defaults to the \code{bin_width}. If no caption is desired, pass a value of \code{NULL}. \code{character}.
#' @param x_title The desired title on the \emph{x}-axis.  Defaults to the \code{variable_name}.  If no axis title is desired, pass a value of \code{NULL}. \code{character}.
#' @param y_title The desired title on the \emph{y}-axis.  Defaults to ``Frequency''. If no axis title is desired, pass a value of \code{NULL}. \code{character}.
#' @param x_axis_format How the \emph{x}-axis digits are formatted. Defaults to \code{scales::comma_format()}.  \code{scale format}.
#' @param font_base_size Sets font size through ggplot2's theme.
#'
#' @return Returns a histogram as a \code{ggplot2} object.
#' @examples
#' library(datasets)
#' #Don't run graphs on a headless machine without any the basic graphics packages installed.
#' if( require(grDevices) & require(nycflights13) ) {
#'   ds               <- nycflights13::flights
#'   ds$date_depart   <- as.Date(ISOdate(ds$year, ds$month, ds$day))
#'   ds$date_blank    <- as.Date(NA)
#'   
#'   histogram_date(ds, variable_name="date_depart", bin_unit="day")
#'   histogram_date(ds, variable_name="date_depart", bin_unit="week")
#'   histogram_date(ds, variable_name="date_depart", bin_unit="month")
#'   histogram_date(ds, variable_name="date_depart", bin_unit="quarter")
#'   histogram_date(ds, variable_name="date_depart", bin_unit="year")
#'   
#'   histogram_date(ds, variable_name="date_depart", bin_unit="day")
#' }

histogram_date <- function(
  d_observed,
  variable_name,
  bin_unit                = c("day", "week", "month", "quarter", "year"),
  main_title              = base::gsub("_", " ", variable_name, perl=TRUE),
  sub_title               = NULL,
  caption                 = paste0("each bin is 1 ", bin_unit, " wide"),
  x_title                 = variable_name,
  y_title                 = "Frequency",
  x_axis_format           = scales::comma_format(),
  font_base_size          = 12
) {
  
  if( !inherits(d_observed, "data.frame") ) 
    stop("`d_observed` should inherit from the data.frame class.")
  
  d_observed <- d_observed[!base::is.na(d_observed[[variable_name]]), ]
  
  non_empty  <- (nrow(d_observed) >= 1L)
  
  if( non_empty ) {
    ds_mid_points <- base::data.frame(label=c("italic(X)[50]", "bar(italic(X))"), stringsAsFactors=FALSE)
    ds_mid_points$value <- c(stats::median(d_observed[[variable_name]]), base::mean(d_observed[[variable_name]]))
    # ds_mid_points$value_pretty  <- sprintf("%.*f", rounded_digits, ds_mid_points$value)
    # ds_mid_points$value_rounded <- base::round(ds_mid_points$value, rounded_digits)
    
    if( ds_mid_points$value[1] < ds_mid_points$value[2] ) {
      h_just <- c( 1.1, -0.1)
    } else {
      h_just <- c(-0.1,  1.1)
    }
    
    range_base <- range(d_observed[[variable_name]])
    # range_lower <- seq.Date(range_base[1], by=paste("-1", bin_unit), length.out = 2)
    range_upper <- seq.Date(range_base[2], by=paste("+1", bin_unit), length.out = 2)
    range_date <- range(range_base, range_upper)
  } else {
    # d_observed    <- tibble::add_row(d_observed, !!(variable_name) := c(-1L, 1L))
    #   rlang::quo(
    #     
    #   )variable_name = c(-1L, 1L)
    # )
    main_title <- paste0("Empty: ", main_title)
    caption    <- "The variable contains only missing values.\nThere is nothing to graph."
    
    ds_mid_points <- tibble::tribble(
      ~label,            ~value  , ~value_rounded,
      "italic(X)[50]",   +Inf, "No non-missing values",
      "bar(italic(X))",  -Inf, "No non-missing values"
    )
    h_just <- c( 1.1, -0.1)
    
    range_date <- seq.Date(from=Sys.Date(), by=bin_unit, length.out = 2)
  }
  
  breaks <- seq.Date(from=range_date[1], to=range_date[2], by=bin_unit)
  palette_midpoint <- c("#2274A5", "#32936F") # https://coolors.co/app/ffbf00-e83f6f-2274a5-32936f-ffffff
  # palette_midpoint <- c("#118AB2", "#06D6A0") # https://coolors.co/app/ef476f-ffd166-06d6a0-118ab2-073b4c
  
  g <- ggplot2::ggplot(d_observed, ggplot2::aes_string(x=variable_name)) +
    ggplot2::geom_histogram(breaks=breaks, closed="left", position=ggplot2::position_identity(), fill="gray92", color="gray80", size=1, alpha=.7) +
    ggplot2::geom_vline(xintercept=ds_mid_points$value, color=palette_midpoint) +
    ggplot2::geom_text(data=ds_mid_points, ggplot2::aes_string(x="value", y=-Inf, label="value"), color=palette_midpoint, hjust=h_just, vjust=-0.2            , na.rm=T) +
    ggplot2::geom_text(data=ds_mid_points, ggplot2::aes_string(x="value", y= Inf, label="label"        ), color=palette_midpoint, hjust=h_just, vjust= 1.2, parse=TRUE, na.rm=T) +
    ggplot2::scale_x_date(labels = scales::date_format("%Y\n%b\n%d")) +
    ggplot2::scale_y_continuous(labels=scales::comma_format()) +
    ggplot2::labs(title=main_title, subtitle=sub_title, caption=caption, x=x_title, y=y_title)

  g <- g + ggplot2::theme_light(base_size = font_base_size) +
    ggplot2::theme(axis.ticks             = ggplot2::element_blank()) +
    ggplot2::theme(panel.grid.major       = ggplot2::element_line(color="gray90")) +
    ggplot2::theme(panel.grid.minor       = ggplot2::element_line(color="gray94")) +
    ggplot2::theme(plot.caption           = ggplot2::element_text(color="gray60")) +
    ggplot2::theme(axis.title.y           = ggplot2::element_text(color="gray60"))
  
  return( g )
}
