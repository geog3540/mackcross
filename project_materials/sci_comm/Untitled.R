library(readr)
library(dplyr)

df <- read_csv("Documents/research/primate_map/project_materials/sci_comm/total_df.csv")

df$total_reduced_free <- as.numeric(df$total_reduced_free)
df$k12_enrollment <- as.numeric(df$k12_enrollment)

grouped <- df %>%
  group_by(county, year) %>%
  summarize(import_ratio = sum(k12_enrollment) / sum(total_reduced_free))
head(grouped)

grouped <- df %>%
  group_by(county_name, year) %>%
  summarize(import_ratio = sum(k12_enrollment, na.rm = TRUE) / sum(total_reduced_free, na.rm = TRUE),
            .groups = "drop")
head(grouped)

write.csv(grouped, "Documents/research/primate_map/project_materials/sci_comm/grouped_data.csv", row.names = FALSE)




