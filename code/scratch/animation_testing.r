###############################################################################
# Demo animation with R packages magick, gganimate, av
#
# Social science data from package gapminder is used - life expectancy vs
# per capita GDP. This follows examples in Magick and gganimate documentation.
#
# The output gif and mp4 files are written to the working directory.
# A directory 'social_demo_graphs' must exist in the working directory to hold
# the png graph images created as part of the av package workflow.
#
# A folder 'output_animations' must exist to hold outputs written to file.
#
# March 2025
###############################################################################

library(tidyverse)
library(magick)
library(av)
library(gganimate)
library(gapminder)


###############################################################################
#  Magick package 
#  output:  gif file
#  approach:  series of ggplots printed to Magick graphics device. Animation
#            created from graphics device and written to file as a gif. A
#            Animation also saved as mp4 video file using renderer from av pkg
#  key functions:  image_write, image_animate, image_graph, image_write
###############################################################################

# open a new graphics device using Magick function image_graph
img <- image_graph(800, 450, res = 96)

# split gapminder table by year
datalist <- split(gapminder, gapminder$year)

# create annual graphs all contained in object 'out', a list of ggplots
out <- lapply(datalist, function(data){
   p <- ggplot(data = data,
               mapping = aes(x = gdpPercap, y = lifeExp, size = pop,
                             color = country)) +
        geom_point(alpha = 0.7, show.legend=FALSE) +
        scale_colour_manual(values = country_colors) +
        scale_size(range = c(2,12)) +
        scale_x_log10(limits = c(100,120000)) +
        scale_y_continuous(limits = c(20,90)) +
        facet_wrap(~continent) +
        labs(title = sprintf("Year: %s", data$year),
             x = 'GDP per capita', y = 'Life Expectancy')
   # print graph to Magick graphics device 'img' 
   print(p)
})
dev.off() 

# animate with Magick function image_animate
animateMagick <- image_animate(img, fps = 2, optimize = TRUE)

# write animation to gif using built-in Magick renderer
image_write(animateMagick, "output_animations/demo_social_data_Magick.gif")

# write animation using av renderer through Magick function image_write_video
image_write_video(animateMagick, 
                  "output_animations/demo_social_data_Magick_video.mp4")



###############################################################################
#  av package - 
#  output:  mp4 file
#  approach:  list of png image files encoded into an mp4 on disk
#  key functions:  av_encode_video
#
#  Note that testing with the mp4 output was mixed. When viewed in Windows with
#  default app (Movies & TV app or within Powerepoint) one frame is dropped.  
#  When viewed with VLC player it is fine - all frames are properly shown.  
#  When viewed on Mac either within Powerpoint or with Quicktime, 
#  all frame are properly shown.
###############################################################################
for (iyr in unique(gapminder$year)) {
  # filter data for year iyr, plot and save as png images
  datafilt <- gapminder[gapminder$year == iyr,]
  p <- ggplot(data = datafilt,
              mapping = aes(x = gdpPercap, y = lifeExp, size = pop,
                            color = country)) +
       geom_point(alpha = 0.7, show.legend=FALSE) +
       scale_colour_manual(values = country_colors) +
       scale_size(range = c(2,12)) +
       scale_x_log10(limits = c(100,120000)) +
       scale_y_continuous(limits = c(20,90)) +
       facet_wrap(~continent) +
       labs(title = sprintf("Year: %s", datafilt$year),
            x = 'GDP per capita', y = 'Life Expectancy')
   fname <- sprintf("social_demo_graphs/social_demo_%2d.png", iyr)
   ggsave(fname, width=800, height=450, dpi=96, units="px")
}

# combine png images into video with function from av package
av_encode_video(list.files("social_demo_graphs", full.names=TRUE), 
                framerate=2, 
                output="output_animations/demo_social_data_av_encode.mp4")



###############################################################################
#  gganimate package - demo with renderer from av package which must be 
#                      installed and loaded
#  output:  mp4 file
#  approach: add two elements to the ggplot command to make gganim object, then
#            render to file using renderer from av package (must be loaded)
#  key functions:  transition_time & ease_aes added to ggplot, and
#                  av_encode_video
###############################################################################

p2 <- ggplot(data = gapminder,
             mapping = aes(x = gdpPercap, y = lifeExp, size = pop,
                           colour = country)) +
      geom_point(alpha = 0.7, show.legend = FALSE) +
      scale_colour_manual(values = country_colors) +
      scale_size(range = c(2,12)) +
      scale_x_log10() +
      facet_wrap(~continent) +
      labs(title = 'Year: {frame_time}',
           x = 'GDP per capita', y = 'Life Expectancy') +
      transition_time(year) +
      ease_aes('linear')

# Magick renderer gives error:
# "Error in if (loop) else 1 : argument is not interpretable as logical"
# animate(p2, renderer = magick_renderer('demo_gganim_Magick.mp4'), fps=2) 

# write to file with gganimate function 'animate' and av renderer
fname2 <- "output_animations/demo_social_data_gganimate_av_render.mp4"
animate(p2, renderer = av_renderer(fname2), 
        width = 800, height = 450, res = 96, fps = 15)






