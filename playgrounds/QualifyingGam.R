rm(list=ls(all=TRUE))
require(ggplot2)

# beaver1
ggplot(beaver1, aes(x=time, y=activ)) +
  geom_point() +
  geom_smooth(method=mgcv::gam)
# geom_smooth(method="mgcv::gam")
