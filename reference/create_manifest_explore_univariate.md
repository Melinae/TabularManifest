# Create a manifest for exploring univariate patterns.

This function creates a meta-dataset (from the `data.frame` passed as a
parameter) and optionally saves the meta-dataset as a CSV. The
meta-dataset specifies how the variables should be plotted.

## Usage

``` r
create_manifest_explore_univariate(
  d_observed,
  write_to_disk = TRUE,
  path_out = getwd(),
  overwrite_file = FALSE,
  default_class_graph = c(numeric = "histogram_continuous", integer =
    "histogram_continuous", factor = "histogram_discrete", character =
    "histogram_discrete", notMatched = "histogram_generic"),
  default_format = c(numeric = "scales::comma", notMatched = "scales::comma"),
  bin_count_suggestion = 30L
)
```

## Arguments

- d_observed:

  The `data.frame` to create metadata for.

- write_to_disk:

  Indicates if the meta-dataset should be saved as a CSV.

- path_out:

  The file path to save the meta-dataset.

- overwrite_file:

  Indicates if the CSV of the meta-dataset should be overwritten if a
  file already exists at the location.

- default_class_graph:

  A `character` array indicating which graph should be used with
  variables of a certain class.

- default_format:

  A `character` array indicating which formatting function should be
  displayed on the axis of the univariate graph.

- bin_count_suggestion:

  An `integer` value of the number of roughly the number bins desired
  for a histogram.

## Value

Returns a `data.frame` where each row in the metadata represents a
column in `d_observed`. The metadata contains the following columns

1.  `variable_name` The variable name (in `d_observed`). `character`.

2.  `remark` A blank field that allows theuser to enter notes in the CSV
    for later reference.

3.  `class` The variable's [`class`](https://rdrr.io/r/base/class.html)
    (eg, numeric, Date, factor). `character`.

4.  `should_graph` A boolean value indicating if the variable should be
    graphed. `logical`.

5.  `graph_function` The name of the function used to graph the
    variable. `character`.

6.  `x_label_format` The name of the function used to format the
    *x*-axis. `character`.

7.  `bin_width` The uniform width of the bins. `numeric`.

8.  `bin_start` The location of the left boundary of the first bin.
    `numeric`.

## Examples

``` r
create_manifest_explore_univariate(datasets::InsectSprays, write_to_disk=FALSE)
#>   variable_name remark   class should_graph       graph_function x_label_format
#> 1         count        numeric         TRUE histogram_continuous  scales::comma
#> 2         spray         factor         TRUE   histogram_discrete  scales::comma
#>   bin_width bin_start rounding_digits
#> 1         1         0               1
#> 2         1         1               1

#Careful, the first column is a `ts` class.
create_manifest_explore_univariate(datasets::freeny, write_to_disk=FALSE)
#>           variable_name remark   class should_graph       graph_function
#> 1                     y             ts         TRUE    histogram_generic
#> 2 lag.quarterly.revenue        numeric         TRUE histogram_continuous
#> 3           price.index        numeric         TRUE histogram_continuous
#> 4          income.level        numeric         TRUE histogram_continuous
#> 5      market.potential        numeric         TRUE histogram_continuous
#>   x_label_format bin_width bin_start rounding_digits
#> 1  scales::comma     1.000     1.000               1
#> 2  scales::comma     0.050     8.750               6
#> 3  scales::comma     0.020     4.260               6
#> 4  scales::comma     0.010     5.820               6
#> 5  scales::comma     0.005    12.965               6
```
