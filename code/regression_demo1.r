###############################################################################
#  Demo 1
#
#  Create a video showing a data stream corresponding with the linear
#  regression model. 
#  
#  Simulate X-Y pairs drawn from a basic linear regression model
#     y_i = m * x_i + b + epsilon   where epsilon = N(0,stdev)
#  X are drawn from uniform random distribution in interval [Xmin, Xmax].
#  Associated Y random values are evaluated with the model.
#
#  The working working directory must contain two sub-directories. The names
#  must match the variables graph_folder and video_folder that are defined in
#  the parameter file.
#
#  Simulations are rows in the output data frame.  The simulations are conducted
#  in iterations of a loop where each iteration results in a group of 
#  simulations. 
#
#  In graphs, the group is used to assign an alpha (transparency) value. A
#  series of graphs are produced by moving sequentially through the groups with
#  the current group being fully opaque and previous groups having increasing
#  levels of transparency.  A maximum transparency is imposed (minimum alpha)
#  so previous groups are always visible with at least the max. transparency.
#
#
#  April 2025
#
###############################################################################

library(tidyverse)
library(ggExtra)
library(grid)
library(av)


# load functions  
source("code/functions/unifX_normY.r")
source("code/functions/regression_demo1_simulate_data.r")
source("code/functions/regression_demo1_make_graphs.r")

            
#  set parameters & initialize data frames
source("code/regression_demo1_prms.r")

# simulate data in groups (Niterations), each group with N simulations
print("Simulate data...")
simDataAll <- sim_data_stream(Niterations, Xmin, Xmax, stdev, m, b, N) 

# make a graph for each group of simulations and save to png files
print("Making graphs...")
if (!make_graphs(simDataAll,alphaVals,graph_folder)) {
  print("Error making graphs.")
}

# combine graph images into a video using function from av package
print("Making video ...")
vidfpath <- str_c(video_folder,"/",fname_mp4, sep="")
av_encode_video(list.files(graph_folder, full.names=TRUE), 
                framerate=8, output=vidfpath, verbose=FALSE)

# clean up
print("Cleaning up ...")
rm(N,b,m,Xmin,Xmax)
rm(alpha_crit_index, alpha_min, alpha_step_interval, alphaVals)
rm(graph_folder, n_alpha_steps, Niterations)
rm(fname_mp4, fname_prefix, video_folder)

print("Completed.")


