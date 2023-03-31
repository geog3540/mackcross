rm(list=ls())

getwd()
library(readxl)
df <- read_excel("Documents/research_projects/primate_map/miocene_ape/raw_ape_data.xlsx", skip = 2)
df2 <- read_excel("Documents/research_projects/primate_map/miocene_ape/raw_ape_data.xlsx", sheet = "SOM  Table S2", skip = 2)
df3 <- read_excel("Documents/research_projects/primate_map/miocene_ape/raw_ape_data.xlsx", sheet = "SOM Table S3.R1", skip = 2)



names(df3)
# Remove unnecessary columns
df3 <- df3[ ,c("Miocene ape species", "Range / Bin")]
# Rename columns of interest
names(df3)[names(df3) == "Miocene ape species"] <- "miocene_ape_species"
names(df3)[names(df3) == "Range / Bin"] <- "date_range"