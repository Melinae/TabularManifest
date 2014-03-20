\name{histogram_discrete}
\alias{histogram_discrete}
\title{Generate a Histogram for a \code{character} or \code{factor} variable.}
\usage{
histogram_discrete(ds_observed, variable_name,
  levels_to_exclude = character(0), main_title = variable_name,
  x_title = NULL, y_title = "Number of Included Records",
  text_size_percentage = 6, bin_width = 1L)
}
\arguments{
  \item{ds_observed}{The \code{data.frame} with the
  variable to graph.}

  \item{variable_name}{The name of the variable to graph.
  \code{character}.}

  \item{levels_to_exclude}{An array of of the levels to be
  excluded from the histogram. Pass an empty variable
  (\emph{ie}, \code{character(0)}) if all levels are
  desired; this is the default. \code{character}.}

  \item{main_title}{The desired title on top of the graph.
  Defaults to \code{variable_name}. If no title is desired,
  pass a value of \code{NULL}. \code{character}.}

  \item{x_title}{The desired title on the \emph{x}-axis.
  Defaults to the number of included records. If no axis
  title is desired, pass a value of \code{NULL}.
  \code{character}.}

  \item{y_title}{The desired title on the \emph{y}-axis.
  Defaults to ``Frequency''. If no axis title is desired,
  pass a value of \code{NULL}. \code{character}.}

  \item{text_size_percentage}{The size of the percentage
  values on top of the bars. \code{character}.}

  \item{bin_width}{(This parameter is included for
  compatibility with other graphing functions.  It should
  always be \code{1} for discrete and boolean variables.)}
}
\value{
Returns a histogram as a \code{ggplot2} object.
}
\description{
Generate a histogram for a \code{character} or
\code{factor} variable.  This graph is intended to quickly
provide the researcher with a quick, yet thorough
representation of the continuous variable.  The additional
annotations may not be desired for publication-quality
plots.
}
\examples{
library(datasets)
#Don't run graphs on a headless machine without any the basic graphics packages installed.
if( require(grDevices) ) {
  histogram_discrete(ds_observed=infert, variable_name="education")
  histogram_discrete(ds_observed=infert, variable_name="age")
}
}

