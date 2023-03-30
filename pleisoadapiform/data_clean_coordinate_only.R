rm(list = ls())
library(readr)
df <- read_csv("Documents/research_projects/primate_map/initial_raw_data/primates_coordinates_a.csv")

df <- subset(df, max_ma > 0)

df$state <- factor(df$state)
names(df)
df <- df[, c("accepted_name", "max_ma", "min_ma", "lng", "lat", "state", "county")]

df$accepted_name <- sub(" ", "_", df$accepted_name)
getwd()
setwd("Documents/research_projects/primate_map/")
write_csv(df, "cleaned_primate_data.csv")

