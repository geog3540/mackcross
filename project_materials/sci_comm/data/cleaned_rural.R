rm(list=ls())
library(rvest)
library(readr)
library(dplyr)
library(tidyverse)

# extract aver pupil spending
tb <- html_table(read_html("https://www.itrlocal.org/per-pupil-school-spending"))
df <- tb[[1]]
# cleaning to prep for merge 
names(df)[names(df) == "FY 2020 Total Overall District Expenditures"] <- "SpendingPerStudent"
df$'District Name' <- tolower(gsub(" ", "", df$'District Name'))
df$SpendingPerStudent <- gsub("\\$|,", "", df$SpendingPerStudent)
df$SpendingPerStudent <- as.numeric(df$SpendingPerStudent)
df$'District Name' <- gsub("-", "", df$'District Name')

# get info on graduation rate 
df2 <- read_csv("2022_21_graduationrate.csv")
df2$'District Name' <- gsub("Comm School District", "", df2$'District Name')
# cleaning to prep for merge 
df2$'District Name' <- tolower(gsub(" ", "", df2$'District Name'))
names(df2)[names(df2) == "Class of 2022 4 Year Graduation Rate"] <- "AvgGradRate4yr"
names(df2)[names(df2) == "Class of 2021 5 Year Graduation Rate"] <- "AvgGradRate5yr"
df2 <- df2[,c("County", "District Name", "AvgGradRate4yr", "AvgGradRate5yr")]
df2$AvgGradRate4yr <- as.numeric(df2$AvgGradRate4yr)
df2$AvgGradRate5yr <- as.numeric(df2$AvgGradRate5yr)
df2$`District Name` <- gsub("-", "", df$`District Name`)

merged_df1 <- merge(df, df2, by = "District Name", all = TRUE)

################################################
actdf <- read_csv("ACT.csv")
actdf$district <- gsub(" CMTY SD", "", actdf$district)
actdf$district <- gsub(" CMTY SCHOOL DISTRICT", "", actdf$district)
actdf$district <- gsub(" CMTY SCH DIST", "", actdf$district)
actdf$district <- gsub(" SD", "", actdf$district)
actdf$district <- gsub(" CMTY SCHOOLS", "", actdf$district)
actdf$district <- gsub(" CSD", "", actdf$district)
actdf$district <- gsub(" SCHOOL DIST", "", actdf$district)
actdf$district <- gsub(" CMTY SCHOOLS", "", actdf$district)
actdf$district <- gsub(" CMTY", "", actdf$district)
actdf$district <- gsub(" CMTY SCHOOLS", "", actdf$district)
actdf$district <- gsub(" PUBLIC", "", actdf$district)
actdf$district <- gsub("RICT", "", actdf$district)
actdf$district <- gsub(" CTL CMSD", "", actdf$district)
actdf$district <- gsub(" CONS", "", actdf$district)
actdf$district <- tolower(gsub(" ", "", actdf$district))
actdf$district <- tolower(gsub(" ", "", actdf$district))
actdf$`Avg Sci` <- as.numeric(actdf$`Avg Sci`)
actdf$`Avg Math` <- as.numeric(actdf$`Avg Math`)
actdf$`Avg Comp` <- as.numeric(actdf$`Avg Comp`)
actdf$district <- gsub("-", "", actdf$district)

new_df <- merge(merged_df1, actdf, by.x = "District Name", by.y = "district", all = TRUE)
names(new_df)[names(new_df) == "District Name"] <- "district"
new_df$district <- gsub("co$", "", new_df$district)

################################################

county_codes <- read_csv("county_codes.csv")
county_codes <- county_codes[,c("County Number", "County Name")]
new_df$County <- as.integer(new_df$County)
merged_df2 <- merge(new_df, county_codes, by.x = "County", by.y = "County Number", all = TRUE)
names(merged_df2)[names(merged_df2) == "County Name"] <- "name"
names(merged_df2)[names(merged_df2) == "Avg Sci"] <- "avg_sci"
names(merged_df2)[names(merged_df2) == "Avg Math"] <- "avg_math"
names(merged_df2)[names(merged_df2) == "Avg Comp"] <- "avg_comp"

district_df <- merged_df2 %>% 
  group_by(County) %>% 
  summarize(name = first(name), 
            CountySpendingPerStudent = mean(SpendingPerStudent, na.rm = TRUE),
            CountyGraduateRate4yr = mean(AvgGradRate4yr, na.rm = TRUE), 
            CountyGraduateRate5yr = mean(AvgGradRate5yr, na.rm = TRUE), 
            mean_math = mean(avg_sci, na.rm = TRUE), 
            mean_sci = mean(avg_math, na.rm = TRUE),
            mean_comp = mean(avg_comp, na.rm = TRUE))

#################################################

df3 <- read_csv("population23.csv")
df3 <- df3[,c("pop2010", "pop2023", "name", "density", "area")]
df3$name <- sub("County$", "", df3$name)
df3$name <- gsub(" ", "_", tolower(df3$name))
df3$name <- sub("_$", "", df3$name)
df3$name <- gsub("'", "", df3$name)
district_df$name <- gsub("'", "", district_df$name)
district_df$name <- gsub(" ", "_", tolower(district_df$name))

merged_df3 <- merge(district_df, df3, by = "name")

################################################

df4 <- read_csv("educational_level.csv")
names(df4)[names(df4) == "Areaname"] <- "name"
df4$name <- gsub(" ", "_", tolower(df4$name))
merged_df4 <- merge(merged_df3, df4, by = "name", all = TRUE)


write.csv(merged_df4, file = "cleaned_rural.csv", row.names = FALSE)





