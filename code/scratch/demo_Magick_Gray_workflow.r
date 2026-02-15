# test Magick gif creation using Gray's workflow

library(magick)

# read and join graph images from file; creates list of magick-image elements
list_imgs <- lapply(list.files("social_demo_graphs", full.names=TRUE), image_read)
   
# join list elements into a magick-image object
joined_imgs <- image_join(list_imgs)
                   
# make animation
magick_anim <- image_animate(joined_imgs, fps=2)

image_write(magick_anim, "output_animations/demo_social_data_Magick_Gray.gif")