rm(list=ls())

library(readr)
df1 <- read_csv("/Users/mackcross/Documents/research_projects/primate_map/data/original/accepted_primates_edit.csv")
df2 <- read_csv("/Users/mackcross/Documents/research_projects/primate_map/data/original/primates_coordinates_a.csv")
getwd()

# MERGING DATASETS BASED ON ACCEPTED NAME
mergedf <- merge(df1, df2, by.x="accepted_name", by.y = "accepted_name")
# df4 <- subset(df3, max_ma != "NA") 
# The above line of code was used to create the coordinate only spreadsheet 
write_csv(mergedf, "noncoordinate_data.csv")






























