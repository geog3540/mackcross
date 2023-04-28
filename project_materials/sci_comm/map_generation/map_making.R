rm(list=ls())
library(readr)
library(choroplethr)
library(choroplethrMaps)
library(dplyr)
library(ggplot2) 
library(plotly)

df <- read.csv("iowa_rural_outreach/cleaned_rural.csv")

data(df_pop_county)
p <- county_choropleth(df_pop_county, state_zoom = "iowa")
p


p <- county_choropleth(df_pop_county, state_zoom = "iowa", num_colors = 1) + 
  scale_fill_gradient(name="Population", 
                      high="blue",
                      low="grey")
print(p)