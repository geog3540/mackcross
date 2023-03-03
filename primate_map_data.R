rm(list = ls())

library(readr)

df <- read_csv("~/Desktop/accepted_primates.csv", skip = 16)
df2 <- read_csv("~/Desktop/primates_coordinates_a.csv")

# Excluding extant primates in df2 
df <- subset(df, is_extant == "extinct")

df$record_type <- NULL
df$flags <- NULL
df$taxon_rank <- NULL
df$difference <- NULL
df$phylum <- NULL
df$ref_author <- NULL
df$pubyr <- NULL
df$ref_pubyr <- NULL




head(df)
colnames(df2)
df$reference_no
sort(df$orig_no)


df3 <- merge(df, df2, by.x = "accepted_name", by.y = "accepted_name")
print(df3)
colnames(df3)
print(df3$accepted_name)

df4 <- subset(df3, max_ma != "NA")
print(df4)
