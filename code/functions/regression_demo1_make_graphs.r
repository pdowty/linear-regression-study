###############################################################################
# 
# make_graphs()
#
# Function that makes series of graphs and saves as png files as part of 
# regression demo 1.
#
# Arguments:
#  simDataAll = data frame with all simulated data needed for series of graphs.
#  alphaVals = data frame with graph alpha levels to control transparency.
#  graph_folder = sub-folder within working directory to same graph images.
#
# Returns an integer indicating succesful execution (1) or failure (0).
#
###############################################################################

make_graphs <- function(simDataAll,alphaVals,graph_folder) {

  # get extreme y values for setting consistent y axis scale range
  y_extreme_obs <- max(max(simDataAll$Y), abs(min(simDataAll$Y)))
  # scale_limit <- 10 * ceiling(y_extreme_obs/10) * 2
  scale_limit <- 100
 
  # Each for loop iteration makes one graph and saves to png file 
  for (i in 1:Niterations) {
    print(sprintf("Function make_graphs:  Graphing plot %d",i))
    
    # filter out records for groups 1 up to group i
    simDataFilt <- simDataAll %>% filter(group <= i)
    
    # add alpha values to data frame
    simDataFilt <- simDataFilt %>%
      mutate(alpha = rev(alphaVals[group,"alphaVals"]))
    
    # make group variable into a factor in reverse order to control draw order
    simDataGraph <- simDataFilt %>% 
      mutate(group = factor(rev(group)))
    
    # open png device to hold coming graph 
    fname <- str_c(graph_folder,"/",fname_prefix,"_",sprintf("%03d",i),".png",
                   sep="")
    png(filename = fname, width=6, height=4, units="in", res=250)
    
    # create graph for this iteration; specify group only for draw order
    p <- ggplot(data = simDataGraph,
                mapping = aes(x=X, y=Y, alpha = alpha, group = group)) +
      geom_point(size=0.5, shape=16) +
      theme_bw() +
      theme(
        legend.position = "none",
        plot.margin = margin(2,2,2,2,unit="pt"),
        axis.title = element_text(size=8),
        axis.text = element_text(size=6),
        panel.grid.major = element_line(linewidth=0.5),
        panel.grid.minor = element_line(linewidth=0.2)
      ) +
      ylim(-50,100) + 
      xlim(Xmin,Xmax) 
    # add marginal histograms
    p2 <- ggMarginal(p, type="histogram", fill="gray90", color="gray70", 
                     linewidth=0.25, size=20)
    print(p2)
    dev.off()
  }   # close for loop for iterating through groups
 
  # return flag for successful execution
  return(1)
   
}    # close function definition



