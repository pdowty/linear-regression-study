###############################################################################
# Function unifX_normY( Xmin, Xmax, m, b, stdev, N)
#
# Returns a data frame with N rows of variables X and Y.
# The X values are random variates drawn from a uniform distribution within 
# the range Xmin to Xmax.
# The Y values are random variate drawn from a normal distribution that for
# the associated value of X is centered at the value m*x + b and has a
# standard deviation of stdev.
#
# Feb 2025 
###############################################################################

library(tidyverse)

unifX_normY <- function(Xmin, Xmax, stdev, m, b, N) {
  
  simData <- data.frame(X = numeric(N), Y = numeric(N))
  
  simData$X <- runif(N, Xmin, Xmax)
  
  residuals <- rnorm(N) * stdev
  
  simData$Y <- m * simData$X + b + residuals
  
  return (simData)
  
}