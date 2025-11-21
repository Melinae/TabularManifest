# Trim extreme quantiles from a variable.

Replaces extreme values with `NA` values.

## Usage

``` r
univariate_trim(scores, quantile_lower = 0, quantile_upper = 1)
```

## Arguments

- scores:

  A vector of values that
  [`quantile()`](https://rdrr.io/r/stats/quantile.html) can accept.

- quantile_lower:

  The lower inclusive bound of values to retain.

- quantile_upper:

  The upper inclusive bound of values to retain.

## Value

Returns a vector of the same `class` as `scores`.

## Examples

``` r
#Exclude the largest 5%
TabularManifest::univariate_trim(scores=datasets::beaver1$temp,
  quantile_lower=0, quantile_upper=.95)
#>   [1] 36.33 36.34 36.35 36.42 36.55 36.69 36.71 36.75 36.81 36.88 36.89 36.91
#>  [13] 36.85 36.89 36.89 36.67 36.50 36.74 36.77 36.76 36.78 36.82 36.89 36.99
#>  [25] 36.92 36.99 36.89 36.94 36.92 36.97 36.91 36.79 36.77 36.69 36.62 36.54
#>  [37] 36.55 36.67 36.69 36.62 36.64 36.59 36.65 36.75 36.80 36.81 36.87 36.87
#>  [49] 36.89 36.94 36.98 36.95 37.00 37.07 37.05 37.00 36.95 37.00 36.94 36.88
#>  [61] 36.93 36.98 36.97 36.85 36.92 36.99 37.01 37.10 37.09 37.02 36.96 36.84
#>  [73] 36.87 36.85 36.85 36.87 36.89 36.86 36.91    NA    NA 37.20    NA 37.20
#>  [85]    NA    NA 37.10 37.20 37.18 36.93 36.83 36.93 36.83 36.80 36.75 36.71
#>  [97] 36.73 36.75 36.72 36.76 36.70 36.82 36.88 36.94 36.79 36.78 36.80 36.82
#> [109] 36.84 36.86 36.88 36.93 36.97 37.15

#Exclude the largest 5% and the smallest 5%
TabularManifest::univariate_trim(scores=datasets::beaver1$temp,
  quantile_lower=.05, quantile_upper=.95)
#>   [1]    NA    NA    NA    NA 36.55 36.69 36.71 36.75 36.81 36.88 36.89 36.91
#>  [13] 36.85 36.89 36.89 36.67    NA 36.74 36.77 36.76 36.78 36.82 36.89 36.99
#>  [25] 36.92 36.99 36.89 36.94 36.92 36.97 36.91 36.79 36.77 36.69 36.62    NA
#>  [37] 36.55 36.67 36.69 36.62 36.64 36.59 36.65 36.75 36.80 36.81 36.87 36.87
#>  [49] 36.89 36.94 36.98 36.95 37.00 37.07 37.05 37.00 36.95 37.00 36.94 36.88
#>  [61] 36.93 36.98 36.97 36.85 36.92 36.99 37.01 37.10 37.09 37.02 36.96 36.84
#>  [73] 36.87 36.85 36.85 36.87 36.89 36.86 36.91    NA    NA 37.20    NA 37.20
#>  [85]    NA    NA 37.10 37.20 37.18 36.93 36.83 36.93 36.83 36.80 36.75 36.71
#>  [97] 36.73 36.75 36.72 36.76 36.70 36.82 36.88 36.94 36.79 36.78 36.80 36.82
#> [109] 36.84 36.86 36.88 36.93 36.97 37.15
```
