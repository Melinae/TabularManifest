# Internal function for creating default bins for dataset variables.

An internal function (ie, that's not currently exposed/exported outside
the package) for creating default bins for dataset variables.

## Usage

``` r
calculate_bins(d_observed, bin_count_suggestion = 30L)
```

## Arguments

- d_observed:

  The `data.frame` with columns to calculate bins.

- bin_count_suggestion:

  An `integer` or `numeric` value for the suggested number of bins for
  each variable.

## Value

Returns a `list`, with two elements. Each element is an array with as
many values as columns in `d_observed`.

1.  `bin_width` The variable name (in `d_observed`).

2.  `bin_start` The variable's
    [`class`](https://rdrr.io/r/base/class.html). (eg, numeric, Date,
    factor)

## Examples

``` r
#calculate_bins(d_observed=datasets::freeny)
#calculate_bins(d_observed=datasets::InsectSprays)
```
