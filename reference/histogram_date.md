# Generate a Histogram for a `date` variable.

Generate a histogram for a `date` variable. This graph is intended to
quickly provide the researcher with a quick, yet thorough representation
of the date. The additional annotations may not be desired for
publication-quality plots.

## Usage

``` r
histogram_date(
  d_observed,
  variable_name,
  bin_unit = c("day", "week", "month", "quarter", "year"),
  main_title = base::gsub("_", " ", variable_name, perl = TRUE),
  sub_title = NULL,
  caption = paste0("each bin is 1 ", bin_unit, " wide"),
  x_title = variable_name,
  y_title = "Frequency",
  x_axis_format = scales::comma_format(),
  font_base_size = 12
)
```

## Arguments

- d_observed:

  The `data.frame` with the variable to graph.

- variable_name:

  The name of the variable to graph. `character`.

- bin_unit:

  The width of the histogram bins. Value is passed to
  [`base::seq.Date()`](https://rdrr.io/r/base/seq.Date.html). Defaults
  to 'day'. `numeric`.

- main_title:

  The desired title on top of the graph. Defaults to `variable_name`,
  with underscores replaced with spaces. If no title is desired, pass a
  value of `NULL`. `character`.

- sub_title:

  The desired subtitle near the top of the graph. Defaults to `NULL` If
  no subtitle is desired, pass a value of `NULL`. `character`.

- caption:

  The desired text in the bottom-right, below the axis. Defaults to the
  `bin_width`. If no caption is desired, pass a value of `NULL`.
  `character`.

- x_title:

  The desired title on the *x*-axis. Defaults to the `variable_name`. If
  no axis title is desired, pass a value of `NULL`. `character`.

- y_title:

  The desired title on the *y*-axis. Defaults to “Frequency”. If no axis
  title is desired, pass a value of `NULL`. `character`.

- x_axis_format:

  How the *x*-axis digits are formatted. Defaults to
  [`scales::comma_format()`](https://scales.r-lib.org/reference/comma.html).
  `scale format`.

- font_base_size:

  Sets font size through ggplot2's theme.

## Value

Returns a histogram as a `ggplot2` object.

## Examples

``` r
# Don't run graphs on a headless machine without any the basic graphics packages installed.
if( require(grDevices) & require(nycflights13) ) {
  ds               <- nycflights13::flights
  ds$date_depart   <- as.Date(ISOdate(ds$year, ds$month, ds$day))
  ds$date_blank    <- as.Date(NA)

  histogram_date(ds, variable_name="date_depart", bin_unit="day")
  histogram_date(ds, variable_name="date_depart", bin_unit="week")
  histogram_date(ds, variable_name="date_depart", bin_unit="month")
  histogram_date(ds, variable_name="date_depart", bin_unit="quarter")
  histogram_date(ds, variable_name="date_depart", bin_unit="year")

  histogram_date(ds, variable_name="date_depart", bin_unit="day")
}
#> Loading required package: nycflights13
```
