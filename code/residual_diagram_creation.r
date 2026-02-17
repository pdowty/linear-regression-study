###############################################################################
#  Generate graphs of residuals for 3 sets of random data.
#  Purpose - to create diagram for linear regression report.
#
#  This code outputs 4 image (png) files each with three graphs arranged
#  horizontally. The intent is these are stacked vertically to make a grid
#  of graphs, e.g. in Powerpoint.
#
#  February 2026
#
###############################################################################

library(tidyverse)


###############################################################################
# set simulation parameters and initialize
###############################################################################
Xmin <- 0
Xmax <- 100
stdev <- 20
m <- 0.25
b <- 0
N <- 10  # number of data points available for regression
Niterations <- 1000   # number of iterations of data collection

# initialize data frame to hold iteration linear regression results
regr_iterations <- data.frame(intcpt=numeric(), se_intcpt=numeric(),
                              p_intcpt=numeric(), slope=numeric(),
                              se_slope=numeric(), p_slope=numeric())


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
# Loop through iterations - assemble data, get regression, store results 
###############################################################################
for (i in seq(1,Niterations)) {
  # print progress to console periodically
  if (i %% 100 == 0) {
    print(sprintf("iteration %d",i))
  }
  # assemble data
  iter_data <- data.frame(x = x_values, y = as.vector(t(y_df[i,])))
  names(iter_data) <- c("x", "y")
  # perform regression
  lm_obj <- lm(y ~ x, data = iter_data)
  # access & store results
  model_summary <- summary(lm_obj)
  coeff_matrix <- model_summary$coefficients
  iter_results <- data.frame(intcpt = coeff_matrix[1,1],
                             se_intcpt = coeff_matrix[1,2],
                             p_intcpt = coeff_matrix[1,4],
                             slope = coeff_matrix[2,1],
                             se_slope = coeff_matrix[2,2],
                             p_slope = coeff_matrix[2,4])
  regr_iterations <- rbind(regr_iterations, iter_results) 
  
  # NEED TO RETRIEVE AND STORE RESIDUALS
  # in vector lm_obj$residuals
  
}


