rm(list=ls())
library(tidyverse)
library(ggplot2)
library(animation)
library(sf)
library(gganimate)

# Read in the data from CSV file
df_points <- read.csv("cleaned_primate_data.csv")

# Find the range of min_ma values
min_ma_range <- rev(range(df_points$min_ma))

df <- df_points %>%
  mutate(time = ifelse(min_ma >= min_ma_range[1] & max_ma <= min_ma_range[1] + 10, min_ma,
                       ifelse(min_ma <= min_ma_range[1] & max_ma >= min_ma_range[1] + 10, min_ma_range[1] + 10,
                              ifelse(min_ma >= min_ma_range[1] & max_ma >= min_ma_range[1] + 10, min_ma_range[1] + 10,
                                     NA))),
         group = sample(letters[1:5], nrow(df_points), replace = TRUE))



# Read in the GeoJSON file and convert to data frame
geo_data <- st_read("map_files/north_south_america_shapefiles.geojson")
df <- as.data.frame(geo_data)

# Plot the data with ggplot()
map <- ggplot() +
  geom_sf(data = geo_data) +
  scale_fill_gradient(low = "blue", high = "red") +
  theme_void()

# Animate the points by time
#animation.gif <- map +
#  transition_manual(time, nframes = 100) +
#  labs(title = "Max and Min MA by Time: {round(frame_time, 1)} Ma") +
#  ease_aes("linear")

# Render the animation
#animate(animation.gif, duration = 20, fps = 10, width = 800, height = 600, renderer = gifski_renderer())
# Create the animated dot map

animation <- map +
  geom_point(data = df, aes(x = lng, y = lat, color = group), size = 3) +
  transition_time(time) +
  labs(title = "Animated Dot Map")

# Save the animation as a .gif file
anim_save("animated_dot_map.gif", animation, renderer = gifski_renderer())





