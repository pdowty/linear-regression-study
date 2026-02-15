###############################################################################
#
#  Linear regression demo 2
#
#  Make a video showing sample x-y data over the background data stream and a
#  separate graph showing the sample slope probability distribution with the
#  corresponding sample slope highlighted.
#
#
#  May 2025
#
###############################################################################


library(tidyverse)
library(av)
source("code/regression_demo2_prms.r")
source("code/functions/regression_demo2_simulate_data.r")


# simulate sets of observations at fixed x values
print("Simulate data...")
simDataAll <- sim_data_samples(Niterations, Xmin, Xmax, stdev, m, b, Nobs) 


# get regression stats for each set of observations



# graph sample data with line over the data stream, and slope value over
# slope sampling distribution