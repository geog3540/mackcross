rm(list = ls())
library(readr)
df <- read_csv("coordinates_primates.csv")

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

# Created new genus columns 
df$genus <- df$accepted_name
df$genus <- gsub("^(\\w+)_.*", "\\1", df$genus)

# Removed redundancy in coordinates
library(dplyr)
df2 <- distinct(df)

df3 <- subset(df2, state != "Fayum" | is.na(state))


df3$genus <- df3$accepted_name
names(df3)
df$genus <- gsub("_", " ", df$genus, fixed=TRUE)

getwd()
write_csv(df3, "cleaned_coordinates_primate_data.csv")








