rm(list=ls())

library(readr)
library(dplyr)
library(rgdal)

# Fill in missing csv values
df <- read_csv("total_df.csv")

df$county_name <- gsub("'", "", df$county_name)
df$county_name <- gsub("OBrien", "Obrien", df$county_name)

library(dplyr)
df_filled <- df %>%
  group_by(county) %>%
  mutate(county_name = ifelse(is.na(county_name), county_name[!is.na(county_name)][1], county_name))


my_shapefile <- readOGR(dsn = "shapefiles/original_Iowa/IowaCounties.shp")


merged_df <- merge(df_filled, my_shapefile@data[c("CountyName", "OBJECTID")], 
                   by.x = "county_name", by.y = "CountyName", all.x = TRUE)

merged_df$total_reduced_free <- as.numeric(merged_df$total_reduced_free)
merged_df$k12_enrollment <- as.numeric(merged_df$k12_enrollment)

grouped <- merged_df %>%
  group_by(OBJECTID, county_name, year) %>%
  summarize(import_ratio = sum(k12_enrollment, na.rm = TRUE) / sum(total_reduced_free, na.rm = TRUE),
            .groups = "drop")
head(grouped)

write.csv(grouped, "grouped_data.csv", row.names = FALSE)




