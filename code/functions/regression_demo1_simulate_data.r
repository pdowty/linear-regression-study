###############################################################################
#
# sim_data_stream()
#
# Function to simulate data stream used for the regression demo 1
#
# Simulations are conducted in for loop iterations where each iteration
# generates N iterations using the function unifX_normY(). This function selects
# N random X values from uniform distribution in interval [Xmin, Xmax]. The
# Y values are then calculated using a linear model with specified slope (m),
# intercept (b) and normal error standard deviation (stdev).
# 
# Function unifX_normY() must be loaded in current session.
#
# Returns data frame with simulated data with 3 columns and N * Niterations of 
# rows.
#
###############################################################################

sim_data_stream <- function(Niterations, Xmin, Xmax, stdev, m, b, N) {

  
  for (i in 1:Niterations) {
    # get simulated values (from unifX_normY.r) 
    simData <- unifX_normY(Xmin, Xmax, stdev, m, b, N) 
    # add variable with iteration number to use for sequential fading
    simData2 <- cbind(simData, group=i) 
    # Append to main data frame
    simDataAll <- rbind(simDataAll, simData2)
  }

  return(simDataAll)
}
