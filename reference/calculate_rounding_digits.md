# Internal function for calculating rounding digits for dataset variables

An internal function (ie, that's not currently exposed/exported outside
the package) for creating default bins for dataset variables.

## Usage

``` r
calculate_rounding_digits(d_observed)
```

## Arguments

- d_observed:

  The `data.frame` with columns to calculate bins.

## Value

Returns a `numeric` vector, indicating how many rounding digits *might*
be appropriate. Each element is an array with as many values as columns
in `d_observed`.

## Examples

``` r
calculate_rounding_digits(d_observed=freeny)
#> [1] 1 6 6 6 6
calculate_rounding_digits(d_observed=InsectSprays)
#> [1] 1 1
calculate_rounding_digits(d_observed=beaver1)
#> [1] 4 4 4 4
```
