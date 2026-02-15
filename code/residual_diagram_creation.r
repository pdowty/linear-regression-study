###############################################################################
#  Generate graphs of residuals for 3 sets of random data.
#  Purpose - to create diagram for linear regression report.
#
#  This code outputs 4 image (png) files each with three graphs arranged
#  horizontally. The intent is these are stacked vertically to make a grid
#  of graphs.
#
#  February 2026
#
###############################################################################

library(tidyverse)


###############################################################################
# set simulation parameters
###############################################################################
Xmin <- 0
Xmax <- 100
stdev <- 20
m <- 0.25
b <- 0
N <- 10  # number of data points available for regression
Niterations <- 1000   # number of iterations of data collection


###############################################################################
# Create data frames with all iterations of input data
###############################################################################
# get x-values of data points - evenly spaced within x domain
n_intervals <- N - 1
x_interval <- (Xmax - Xmin) / n_intervals
x_values <- seq(0,(N-1)) * x_interval

# convert x vector to 2D data frame with the vector repeated as Niterations rows
list_of_x_cols <- lapply(x_values, function(x) {
  rep(x, times=Niterations)
})
x_df <- as.data.frame(list_of_x_cols)
col_names <- lapply(seq(1,N), function(x) {
  str_c("X",x)
})
names(x_df) <- col_names

# create table (data frame) of residuals values (rows x cols = Niterations x N)
resid_matrix <- matrix(rnorm(N*Niterations) * stdev, nrow=Niterations, ncol=N)
residuals <- as.data.frame(resid_matrix)

# create table of y values
y_df <- m * x_df + b + residuals


###############################################################################
# Get linear regression lines and stats for all iterations of input data 
###############################################################################







