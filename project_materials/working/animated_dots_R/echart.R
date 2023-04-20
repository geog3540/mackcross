rm(list=ls())
library(tidyverse)
library(ggplot2)
library(gganimate)
library(tidyverse)
library(animation)
library(sf)
library(echarts4r)

# Read in the data from CSV file
df_points <- read_csv("data/paleobio/cleaned_coordinates_primate_data.csv")

df <- df_points %>%
  mutate(time = min_ma) %>%
  filter(time <= max_ma) %>%
  mutate(exit = ifelse(time == max_ma, TRUE, FALSE))

# Read in the GeoJSON file and convert to data frame
geo_data <- st_read("map/americas_polygons_points/north_south_america_shapefiles.geojson")
df_map <- as.data.frame(geo_data)

map <- ggplot() +
  geom_sf(data = geo_data, fill = "lightblue") +
  theme_void()

# Plot the map with ggplot()
df %>%
  group_by(time) %>%
  e_chart(time, timeline = TRUE) %>%
  e_scatter(x = lng, y = lat, symbol_size = 10, symbol = 'circle') %>%
  e_visual_map(min = 30, max = 90, type = 'piecewise') %>%
  e_title("Life expectancy by coordinate and year", left = "center") %>%
  e_tooltip(
    trigger = "item",
    formatter = e_tooltip_pointer_formatter())

# Save the animation as a .gif file
anim_save("animated_dot_map4.gif", animation, renderer = gifski_renderer())

