###############################################################################
#
#  sim_data_samples()
#
#  Function to generate sample data of y values associated with a set of x 
#  values.
#
#  The x values are selected so that the number of values is argument N, and
#  they are spread out equidistant within the [Xmin, Xmax] interval.
#
#  May 2025
#
###############################################################################


sim_data_samples <- function(Niterations, Xmin, Xmax, stdev, m, b, N) {
  
  # Make column of all x values - all obs for all iterations
  # then get y values.  No looping needed.
 
  # Start output data frame with index variable, a sequence of observation IDs
  # repeated as a set for each iteration.
  SimSampData <- data.frame(obsID = rep(seq(1:N), Niterations)) 
  
  # Create observation x values evenly spaced within Xmax-Xmin interval
  deltaX <- (Xmax - Xmin)/N
  SimSampData <- SimSampData %>%
    mutate(X = (obsID - 1)*deltaX + Xmin,
           Y = 4,
           group = 1)
          
# z = (X - Xbar)/sigma
# z * sigma = X - Xbar
# X = Xbar + z*sigma
    
  # get y values
     
    
  # bind iteration as record to output table
     
  
  return(SimSampData) 
}