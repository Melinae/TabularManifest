##' @name ScatterModelDiscreteXBinaryYLogit
##' @export
##' 
##' @title Internal function for examining a logit performance
##' 
##' @description Internal function for examining a logit performance
##' 
##' @param dsPlot The \code{data.frame} of observed and predicted values to plot.
##' @param xName The name of the predictor \code{character}.
##' @param yName The name of the observed response \code{character}.
##' @param yHatName The name of the predicted response \code{character}.
##' @param residualName The name of the model residual. \code{character}.
##' @param alphaPoint The transparency of each plotted point. A \code{numeric} value from 0 to 1.
##' @param alphaSEBand  The transparency of the standard error bands. A \code{numeric} value from 0 to 1.
##' @param xLabelFormat The name of the function used to format the \emph{x}-axis. \code{character}.
##' @param colorSmoothObserved The plotted color of the observed values' GAM trend.  \code{character}.
##' @param colorSmoothPredicted The plotted color of the predicted's GAM trend.  \code{character}.
##' @param colorSmoothResidual The plotted color of the residual's GAM trend.  \code{character}.
##' @param colorGroupCount The color indicating how many cases belong to each level.  \code{character}.
##' @param verticalLimits The plotted limits of the response variable. A two-element \code{numeric} array.
##' @param jitterObserved A function dictating how the observed values are jittered.
##' @param jitterPredicted A function dictating how the predicted values are jittered.
##' @param seedValue The value of the RNG seed, which affects jittering. No seed is set if a value of \code{NA} is passed.  \code{numeric}.

ScatterModelDiscreteXBinaryYLogit <- function(   
  dsPlot, 
  xName, 
  yName = "y", 
  yHatName = "yhat", 
  residualName = "residual",
  alphaPoint = .05, 
  alphaSEBand = .15, 
  xLabelFormat = scales::comma,
  colorSmoothObserved = "#1b9e77",
  colorSmoothPredicted = "#d95f02",
  colorSmoothResidual = "#7570b3",
  colorGroupCount="tomato",
  verticalLimits = c(-.05, 1.05),
  jitterObserved = ggplot2::position_jitter(w=.35, h=.2), 
  jitterPredicted = ggplot2::position_jitter(w=.35, h=0),
  seedValue = NA_real_
) {
  
   purchase_relationship_theme <- ggplot2::theme(
      axis.title          = ggplot2::element_text(color="gray30", size=9),
      axis.text           = ggplot2::element_text(color="gray30"),
      axis.ticks.length   = grid::unit(0, "cm"), #g <- g + theme(axis.ticks=element_blank())
      axis.ticks.margin   = grid::unit(.00001, "cm"),
      #   panel.grid.minor.y  = element_line(color="gray90", size=.1),
      panel.grid.major    = ggplot2::element_line(color="gray85", size=.15),
      panel.margin        = grid::unit(c(0, 0, 0, 0), "cm"),
      plot.margin         = grid::unit(c(0, .05, .25, 0), "cm")
    )
  
  if( !is.na(seedValue) )
    set.seed(seedValue) #Set a seed so that jittering doesn't create new graphs for git to manage.
  
  gObs <- ggplot2::ggplot(dsPlot, ggplot2::aes_string(x=xName, y=yName)) +
    ggplot2::geom_point(pch=1, alpha=alphaPoint, na.rm=T, position=jitterObserved) +
    ggplot2::stat_summary(fun.y="mean", geom="point", color=colorSmoothObserved, shape=5, size=10) + #Chang's Cookbook, Section 6.8
    ggplot2::stat_summary(fun.y="median", geom="point", color=colorSmoothObserved, shape="--", size=15) +
    ggplot2::geom_text(ggplot2::aes(label=paste0("n=",scales::comma( ..count..)), y=NULL), y=Inf, stat="bin", vjust=1.4, col=colorGroupCount, size=4, na.rm=TRUE) +
    ggplot2::scale_x_discrete(label=xLabelFormat) +
    ggplot2::scale_y_continuous(limits=verticalLimits, breaks=0:1, labels=c("No", "    Yes")) + #The extra spaces are a hack to get the panels to line up.
    #     scale_y_continuous(limits=c(0,1), breaks=0:2, labels=c("No", "Yes","100%")) + #A failed attempt to get the panel borders to line up.
    ggplot2::theme_bw() +
    ggplot2::labs(x=NULL, y="Purchased") + 
    purchase_relationship_theme
  
  gPredicted <- ggplot2::ggplot(dsPlot, ggplot2::aes_string(x=xName, y=yHatName)) +
    ggplot2::geom_point(pch=1, alpha=alphaPoint, na.rm=T, position=jitterPredicted) +
    ggplot2::geom_boxplot(na.rm=TRUE, color=colorSmoothPredicted, outlier.size=0, size=.5, fill=NA) + 
    ggplot2::stat_summary(fun.y="mean", geom="point", color=colorSmoothPredicted, shape=5, size=10) + #Chang's Cookbook, Section 6.8
    ggplot2::stat_summary(ggplot2::aes_string(y=yName),fun.y="mean", geom="point", color=colorSmoothObserved, shape=5, size=5) + #Chang's Cookbook, Section 6.8
    ggplot2::scale_x_discrete(label=xLabelFormat) +
    ggplot2::scale_y_continuous(limits=verticalLimits, label=scales::percent) +
    ggplot2::theme_bw() +
    ggplot2::labs(x=NULL, y="Predicted Pr(purchase)")  + 
    purchase_relationship_theme 
  
  gResidual <- ggplot2::ggplot(dsPlot, ggplot2::aes_string(x=xName, y=residualName)) +
    ggplot2::geom_point(pch=1, alpha=alphaPoint, na.rm=T, position=jitterPredicted) +
    ggplot2::geom_boxplot(na.rm=TRUE, color=colorSmoothResidual, outlier.size=0, size=.5, fill=NA) + 
    ggplot2::stat_summary(fun.y="mean", geom="point", color=colorSmoothResidual, shape=5, size=10) + #Chang's Cookbook, Section 6.8
    ggplot2::scale_x_discrete(label=xLabelFormat) +
    ggplot2::scale_y_continuous(breaks=c(-2,0,2), labels=c("-2", "0","       2")) + #The extra spaces are a hack to get the panels to line up.
    ggplot2::theme_bw() +
    ggplot2::labs(x=NULL, y="Residual") + 
    purchase_relationship_theme
  
  #TODO: consider replacing with gridExtra::grid.arrange
  vpLayout <- function(x, y) { grid::viewport(layout.pos.row=x, layout.pos.col=y) }
  layout_spec <- grid::grid.layout(nrow=4, ncol=1, heights=grid::unit(x=c(2, 1, 1, 1), units=c("line", "null", "null", "null")))
  grid::grid.newpage()
  grid::pushViewport(grid::viewport(layout=layout_spec))
  vpLabel <- grid::viewport(name="vpLabel", layout.pos.row=1)
  grid::pushViewport(vpLabel)
  grid::grid.rect(gp=grid::gpar(fill="gray90", col=NA))
  grid::grid.text(xName)
  grid::popViewport()
  print(gObs, vp=vpLayout(2, 1))
  print(gPredicted, vp=vpLayout(3, 1))
  print(gResidual, vp=vpLayout(4, 1))
  grid::popViewport()    
}
