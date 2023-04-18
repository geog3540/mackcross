rm(list=ls())

library(ggplot2)
library(animation)
library(sf)

# Read in the GeoJSON file and convert to data frame
geo_data <- st_read("map_files/north_south_america_shapefiles.geojson")
df <- as.data.frame(geo_data)

# Plot the data with ggplot()
map <- ggplot() +
  geom_sf(data = geo_data) +
  scale_fill_gradient(low = "blue", high = "red") +
  theme_void()

# Read in the data from CSV file
df_points <- read.csv("cleaned_primate_data.csv")

# Create the dataset of points with time and group variables
# df <- df_points %>%
#  mutate(time = (max_ma - min_ma) / 10 * 1:nrow(df_points) + min_ma,
#         group = sample(letters[1:5], nrow(df_points), replace = TRUE))

# Create the dataset of points with time and group variables
df <- df_points %>%
  mutate(time = (max_ma - min_ma) / 10 * (1:nrow(df_points) - which.min(min_ma)) + min_ma,
         group = sample(letters[1:5], nrow(df_points), replace = TRUE)) %>%
  filter(time <= max_ma) %>%
  mutate(exit = ifelse(time == max_ma, TRUE, FALSE))


# Create the animated dot map
animation <- map +
  geom_point(data = df, aes(x = lng, y = lat, color = group), size = 3) +
  transition_time(time) +
  labs(title = "Animated Dot Map")

# Save the animation as a .gif file
anim_save("animated_dot_map.gif", animation, renderer = gifski_renderer())





