rm(list=ls())
library(tidyverse)
library(ggplot2)
library(gganimate)
library(tidyverse)
library(animation)
library(sf)

# Read in the data from CSV file
df_points <- read_csv("data/paleobio/cleaned_coordinates_primate_data.csv")

df <- df_points %>%
  mutate(time = min_ma) %>%
  filter(time <= max_ma) %>%
  mutate(exit = ifelse(time == max_ma, TRUE, FALSE))

# Read in the GeoJSON file and convert to data frame
geo_data <- st_read("~/Documents/research/primate_map/project_materials/map/americas_polygons_points/north_south_america_shapefiles.geojson")
df_map <- as.data.frame(geo_data)

# Plot the map with ggplot()
map <- ggplot() +
  geom_sf(data = geo_data, fill = "lightblue") +
  theme_void()

# Create the animated dot map
animation <- map +
  geom_point(data = df, aes(x = lng, y = lat), size = 3) +
  transition_reveal(time) +
  labs(title = "{round(frame_time, 1)} million years ago")

# Save the animation as a .gif file
anim_save("animated_dot_map.gif", animation, renderer = gifski_renderer())


