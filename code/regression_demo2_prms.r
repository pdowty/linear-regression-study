###############################################################################
#  set parameters for the regression demo 2 program (regression_demo2.r)
###############################################################################

graph_folder <- "regression_demo2_graphs"  # folder for output graphs
fname_prefix <- "demo2_graph"    # prefix for output graph file names
video_folder <- "output_animations"     # folder for output video
fname_mp4 <- "reggiejackson_model.mp4"     # video output filename

# set simulation parameters
Xmin <- 0
Xmax <- 100
stdev <- 10
m <- 0.5
b <- 0
Nobs <- 25  # number of observations in sample data record

# number of simulations 
Niterations <- 10000

# initialize data frame to hold all simulated data
simDataAll <- data.frame(X = numeric(), Y = numeric(),
                         group = numeric())


# initialize vector of group alpha values. Each iteration within a group
# is assigned the group alpha value 
alpha_min <- 0.2  # min alpha value so pts don't vanish (at alpha=0)
n_alpha_steps <- 10  # number of discrete alpha levels of transparency
# initialize data frame for alpha vals with calumn 'group' of consecutive ints
alphaVals <- data.frame(group=seq(1:Niterations))
# Get group number (row number) beyond which alpha values will be assigned alpha_min 
alpha_crit_index <- n_alpha_steps + 1
# get alpha value increments between levels of transparency
alpha_step_interval <- (1 - alpha_min) / n_alpha_steps
# set alpha values for each simulation group 
alphaVals <- alphaVals %>%
     mutate(alphaVals=ifelse(group <= alpha_crit_index,
                             1.0 - (group - 1) * alpha_step_interval,
                             alpha_min))