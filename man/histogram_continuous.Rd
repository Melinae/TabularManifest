% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/histogram-continuous.R
\name{histogram_continuous}
\alias{histogram_continuous}
\title{Generate a Histogram for a \code{numeric} or \code{integer} variable.}
\usage{
histogram_continuous(
  d_observed,
  variable_name,
  bin_width = NULL,
  main_title = base::gsub("_", " ", variable_name, perl = TRUE),
  sub_title = NULL,
  caption = paste0("each bin is ", scales::comma(bin_width), " units wide"),
  x_title = variable_name,
  y_title = "Frequency",
  x_axis_format = scales::comma_format(),
  rounded_digits = 0L,
  font_base_size = 12
)
}
\arguments{
\item{d_observed}{The \code{data.frame} with the variable to graph.}

\item{variable_name}{The name of the variable to graph. \code{character}.}

\item{bin_width}{The width of the histogram bins. If NULL, the \code{ggplot2} default is used. \code{numeric}.}

\item{main_title}{The desired title on top of the graph.  Defaults to \code{variable_name}, with underscores replaced with spaces. If no title is desired, pass a value of \code{NULL}. \code{character}.}

\item{sub_title}{The desired subtitle near the top of the graph.  Defaults to \code{NULL} If no subtitle is desired, pass a value of \code{NULL}. \code{character}.}

\item{caption}{The desired text in the bottom-right, below the axis.  Defaults to the \code{bin_width}. If no caption is desired, pass a value of \code{NULL}. \code{character}.}

\item{x_title}{The desired title on the \emph{x}-axis.  Defaults to the \code{variable_name}.  If no axis title is desired, pass a value of \code{NULL}. \code{character}.}

\item{y_title}{The desired title on the \emph{y}-axis.  Defaults to ``Frequency''. If no axis title is desired, pass a value of \code{NULL}. \code{character}.}

\item{x_axis_format}{How the \emph{x}-axis digits are formatted. Defaults to \code{scales::comma_format()}.  \code{scale format}.}

\item{rounded_digits}{The number of decimals to show for the mean and median annotations. \code{character}.}

\item{font_base_size}{Sets font size through ggplot2's theme.}
}
\value{
Returns a histogram as a \code{ggplot2} object.
}
\description{
Generate a histogram for a \code{numeric} or \code{integer} variable.  This graph is intended to quickly provide
the researcher with a quick, yet thorough representation of the continuous variable.  The additional annotations may not
be desired for publication-quality plots.
}
\examples{
library(datasets)
#Don't run graphs on a headless machine without any the basic graphics packages installed.
if (require(grDevices)) {
  # Simple Case
  histogram_continuous(
    d_observed = beaver1,
    variable_name  = "temp",
    bin_width      = .1,
    rounded_digits = 2
   )

  # Variable has no nonmissing values
  histogram_continuous(
    d_observed     = beaver1[integer(0), ],
    variable_name  = "temp",
    bin_width      = .1,
    rounded_digits = 2
  )

  # Adjust cosmetics of histogram
  histogram_continuous(
    d_observed         = beaver1,
    variable_name      = "temp",
    bin_width          = .1,
    rounded_digits     = 2,
    x_axis_format      = scales::comma_format(),
    y_title            = "Count of 10-min Measurements"
  )
}
}
