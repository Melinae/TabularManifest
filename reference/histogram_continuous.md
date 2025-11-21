# Generate a Histogram for a `numeric` or `integer` variable.

Generate a histogram for a `numeric` or `integer` variable. This graph
is intended to quickly provide the researcher with a quick, yet thorough
representation of the continuous variable. The additional annotations
may not be desired for publication-quality plots.

## Usage

``` r
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
```

## Arguments

- d_observed:

  The `data.frame` with the variable to graph.

- variable_name:

  The name of the variable to graph. `character`.

- bin_width:

  The width of the histogram bins. If NULL, the `ggplot2` default is
  used. `numeric`.

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

- rounded_digits:

  The number of decimals to show for the mean and median annotations.
  `character`.

- font_base_size:

  Sets font size through ggplot2's theme.

## Value

Returns a histogram as a `ggplot2` object.

## Examples

``` r
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
```
