#' @name scatter_model_continuous_x_binary_y_logit
#' @export
#'
#' @title Internal function for examining a logit performance
#'
#' @description Internal function for examining a logit performance
#'
#' @param d_plot The \code{data.frame} of observed and predicted values to plot.
#' @param x_name The name of the predictor \code{character}.
#' @param y_name The name of the observed response \code{character}.
#' @param yhat_name The name of the predicted response \code{character}.
#' @param residual_name The name of the model residual. \code{character}.
#' @param alpha_point The transparency of each plotted point. A \code{numeric} value from 0 to 1.
#' @param alpha_se_band  The transparency of the standard error bands. A \code{numeric} value from 0 to 1.
#' @param x_label_format The name of the function used to format the \emph{x}-axis. \code{character}.
#' @param color_smooth_observed The plotted color of the observed values' GAM trend.  \code{character}.
#' @param color_smooth_predicted The plotted color of the predicted's GAM trend.  \code{character}.
#' @param color_smooth_residual The plotted color of the residual's GAM trend.  \code{character}.
#' @param vertical_limits The plotted limits of the response variable. A two-element \code{numeric} array.
#' @param jitter_observed A function dictating how the observed values are jittered.
#' @param jitter_predicted A function dictating how the predicted values are jittered.
#' @param seed_value The value of the RNG seed, which affects jittering. No seed is set if a value of \code{NA} is passed.  \code{numeric}.
#'
#' @examples
#' ds <-
#'   mtcars |>
#'   dplyr::mutate(
#'     # am  = as.logical(am)
#'   ) |>
#'   dplyr::select(
#'     mpg,
#'     am,
#'   ) |>
#'   tibble::rownames_to_column("model")
#'
#' # scatter_model_continuous_x_binary_y_logit(
#' #   d_plot = ds,
#' #   x_name = "mpg",
#' #   y_name = "am",
#' #   yhat_name = NULL
#' # )
#'
scatter_model_continuous_x_binary_y_logit <- function(
  d_plot,
  x_name,
  y_name = "y",
  yhat_name = "yhat",
  residual_name = "residual",
  alpha_point = .05,
  alpha_se_band = .15,
  x_label_format = scales::comma,
  color_smooth_observed = "#1b9e77",
  color_smooth_predicted = "#d95f02",
  color_smooth_residual = "#7570b3",
  vertical_limits = c(-.05, 1.05),
  jitter_observed = ggplot2::position_jitter(w=0, h=.2),
  jitter_predicted = ggplot2::position_jitter(w=0, h=0),
  seed_value = NA_real_
) {

#     require(ggplot2, quietly=TRUE)
#     require(mgcv, quietly=TRUE) #For the Generalized Additive Model that smooths the longitudinal graphs.
#
    purchase_relationship_theme <- ggplot2::theme(
      axis.title          = ggplot2::element_text(color="gray30", size=9),
      axis.text           = ggplot2::element_text(color="gray30"),
      axis.ticks          = ggplot2::element_blank(),
      axis.text.x         = ggplot2::element_text(margin = ggplot2::margin(.00001, 0, 0, 0, "cm")),
      #   panel.grid.minor.y  = element_line(color="gray90", size=.1),
      panel.grid.major    = ggplot2::element_line(color="gray85", size=.15),
      panel.spacing       = grid::unit(c(0, 0, 0, 0), "cm"),
      plot.margin         = grid::unit(c(0, .05, .25, 0), "cm")
    )

  if( !is.na(seed_value) )
    set.seed(seed_value) #Set a seed so that jittering doesn't create new graphs for git to manage.

    browser()
  g_obs <- ggplot2::ggplot(d_plot, ggplot2::aes(x=!! rlang::enquo(x_name), y=!! rlang::enquo(y_name))) +
    ggplot2::geom_point(pch=1, alpha=alpha_point, na.rm=TRUE, position=jitter_observed) +
    ggplot2::geom_smooth(method="gam", formula=y~s(x,bs="cs"), alpha=alpha_se_band, color=color_smooth_observed, fill=color_smooth_observed, size=1, na.rm=TRUE) +
    ggplot2::scale_x_continuous() +
    ggplot2::scale_y_continuous(limits=vertical_limits, breaks=0:1, labels=c("No", "    Yes")) + #The extra spaces are a hack to get the panels to line up.
    #     scale_y_continuous(limits=c(0,1), breaks=0:2, labels=c("No", "Yes","100%")) + #A failed attempt to get the panel borders to line up.
    ggplot2::theme_light() +
    ggplot2::labs(x=NULL, y="Purchased") +
    purchase_relationship_theme

  g_predicted <- ggplot2::ggplot(d_plot, ggplot2::aes(x=!! rlang::enquo(x_name), y=!! rlang::enquo(yhat_name))) +
    ggplot2::geom_point(pch=1, alpha=alpha_point, na.rm=TRUE, position=jitter_predicted) +
    ggplot2::geom_smooth(method=mgcv::gam, formula=y~s(x,bs="cs"), alpha=alpha_se_band, color=color_smooth_predicted, fill=color_smooth_predicted, size=1, na.rm=TRUE) +
    ggplot2::geom_smooth(ggplot2::aes(y=!! rlang::ensym(y_name)), method="gam", formula=y~s(x,bs="cs"), alpha=alpha_se_band*alpha_se_band, color=color_smooth_observed, fill=color_smooth_observed, na.rm=TRUE) +
    ggplot2::scale_x_continuous(label=x_label_format) +
    ggplot2::scale_y_continuous(limits=vertical_limits, label=scales::percent) +
    ggplot2::theme_light() +
    ggplot2::labs(x=NULL, y="Predicted Pr(purchase)")  +
    purchase_relationship_theme

  g_residual <- ggplot2::ggplot(d_plot, ggplot2::aes(x=!! rlang::enquo(x_name), y=!! rlang::enquo(residual_name))) +
    ggplot2::geom_point(pch=1, alpha=alpha_point, na.rm=TRUE, position=jitter_predicted) +
    ggplot2::geom_smooth(method=mgcv::gam, formula=y~s(x,bs="cs"), alpha=alpha_se_band, color=color_smooth_residual, fill=color_smooth_residual, size=1, na.rm=TRUE) +
    ggplot2::scale_x_continuous(label=x_label_format) +
    ggplot2::scale_y_continuous(breaks=c(-2,0,2), labels=c("-2", "0","       2")) + #The extra spaces are a hack to get the panels to line up.
    ggplot2::theme_light() +
    ggplot2::labs(x=NULL, y="Residual") +
    purchase_relationship_theme

  #TODO: consider replacing with gridExtra::grid.arrange
  vp_layout <- function(x, y) { grid::viewport(layout.pos.row=x, layout.pos.col=y) }
  layout_spec <- grid::grid.layout(nrow=4, ncol=1, heights=grid::unit(x=c(2, 1, 1, 1), units=c("line", "null", "null", "null")))
  grid::grid.newpage()
  grid::pushViewport(grid::viewport(layout=layout_spec))
  vp_label <- grid::viewport(name="vp_label", layout.pos.row=1)
  grid::pushViewport(vp_label)
  grid::grid.rect(gp=grid::gpar(fill="gray90", col=NA))
  grid::grid.text(x_name)
  grid::popViewport()
  print(g_obs, vp=vp_layout(2, 1))
  print(g_predicted, vp=vp_layout(3, 1))
  print(g_residual, vp=vp_layout(4, 1))
  grid::popViewport()
}
