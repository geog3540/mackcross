rm(list = ls())
library(readr)
df <- read_csv("~/Documents/research_projects/primate_map/initial_raw_data/primates_coordinates_a.csv")

# Filtered out entries without preexisting date and GIS coordinates 
df <- subset(df, max_ma > 0)

# Adjusted data types
df$state <- factor(df$state)
df$lng <- factor(df$lng)
df$lat <- factor(df$lat)

names(df)
# Deleted unnecessary columns 
df <- df[, c("accepted_name", "max_ma", "min_ma", "lng", "lat", "state", "county")]

# Made species name R friendly 
df$accepted_name <- sub(" ", "_", df$accepted_name)

# Removed redundancy in coordinates
library(dplyr)
df2 <- distinct(df)

df3 <- subset(df2, state != "Fayum" | is.na(state))

getwd()
# Set new working directly in console 
write_csv(df3, "cleaned_primate_data.csv")




