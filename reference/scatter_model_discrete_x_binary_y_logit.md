# Internal function for examining a logit performance

Internal function for examining a logit performance

## Usage

``` r
scatter_model_discrete_x_binary_y_logit(
  d_plot,
  x_name,
  y_name = "y",
  yhat_name = "yhat",
  residual_name = "residual",
  alpha_point = 0.05,
  alpha_se_band = 0.15,
  x_label_format = scales::comma,
  color_smooth_observed = "#1b9e77",
  color_smooth_predicted = "#d95f02",
  color_smooth_residual = "#7570b3",
  color_group_count = "tomato",
  vertical_limits = c(-0.05, 1.05),
  jitter_observed = ggplot2::position_jitter(w = 0.35, h = 0.2),
  jitter_predicted = ggplot2::position_jitter(w = 0.35, h = 0),
  seed_value = NA_real_
)
```

## Arguments

- d_plot:

  The `data.frame` of observed and predicted values to plot.

- x_name:

  The name of the predictor `character`.

- y_name:

  The name of the observed response `character`.

- yhat_name:

  The name of the predicted response `character`.

- residual_name:

  The name of the model residual. `character`.

- alpha_point:

  The transparency of each plotted point. A `numeric` value from 0 to 1.

- alpha_se_band:

  The transparency of the standard error bands. A `numeric` value from 0
  to 1.

- x_label_format:

  The name of the function used to format the *x*-axis. `character`.

- color_smooth_observed:

  The plotted color of the observed values' GAM trend. `character`.

- color_smooth_predicted:

  The plotted color of the predicted's GAM trend. `character`.

- color_smooth_residual:

  The plotted color of the residual's GAM trend. `character`.

- color_group_count:

  The color indicating how many cases belong to each level. `character`.

- vertical_limits:

  The plotted limits of the response variable. A two-element `numeric`
  array.

- jitter_observed:

  A function dictating how the observed values are jittered.

- jitter_predicted:

  A function dictating how the predicted values are jittered.

- seed_value:

  The value of the RNG seed, which affects jittering. No seed is set if
  a value of `NA` is passed. `numeric`.

## Examples

``` r
ds <-
  mtcars |>
  dplyr::mutate(
    cyl  = as.character(cyl)
  ) |>
  dplyr::select(
    cyl,
    am,
  ) |>
  tibble::rownames_to_column("model")

# scatter_model_discrete_x_binary_y_logit(
#   d_plot = ds,
#   x_name = "cyl",
#   y_name = "am",
#   yhat_name = NULL
# )
```
