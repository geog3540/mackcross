rm(list=ls())

library(readr)
# Skip specification used to ignore metadata 
specimens_df <- read_csv("data/specimens_original.csv", skip = 17)
taxa_df <- read_csv("data/taxa_original.csv", skip = 16)

# CLEANIING - SPECIMENS_DF
# Checked column names of data frame
colnames(specimens_df)

# Deleting columns not relevant to analyses 
specimens_df$specimen_no <- NULL
specimens_df$record_type <- NULL
specimens_df$flags <- NULL
specimens_df$occurrence_no <- NULL
specimens_df$reid_no <- NULL
specimens_df$collection_no <- NULL
specimens_df$specimen_id <- NULL 
specimens_df$is_type <- NULL
specimens_df$specelt_no <- NULL
specimens_df$specimen_side <- NULL
specimens_df$specimen_part <- NULL 
specimens_df$specimen_sex <- NULL
specimens_df$n_measured <- NULL
specimens_df$measurement_source <- NULL
specimens_df$magnification <- NULL
specimens_df$comments <- NULL
specimens_df$identified_no <- NULL
specimens_df$accepted_no <- NULL
specimens_df$reference_no <- NULL 
specimens_df$phylum <- NULL
specimens_df$class <- NULL
specimens_df$order <- NULL

# Checked and changed data class
sapply(specimens_df, class)
specimens_df$identified_rank <- factor(specimens_df$identified_rank)
specimens_df$family <- factor(specimens_df$family)
specimens_df$genus <- factor(specimens_df$genus)

# CLEANING - TAXA_DF
# Checked column names of data frame
colnames(taxa_df)

# Deleting columns not relevant to analyses 
taxa_df$orig_no <- NULL
taxa_df$taxon_no <- NULL
taxa_df$record_type <- NULL
taxa_df$flags <- NULL
taxa_df$taxon_rank <- NULL
taxa_df$accepted_no <- NULL
taxa_df$parent_no <- NULL
taxa_df$reference_no <- NULL
taxa_df$n_occs <- NULL
taxa_df$phylum <- NULL
taxa_df$class <- NULL
taxa_df$order <- NULL
taxa_df$type_taxon <- NULL


# Checked and changed data class
sapply(taxa_df, class)
taxa_df$accepted_rank <- factor(taxa_df$accepted_rank)
taxa_df$is_extant <- factor(taxa_df$is_extant)
taxa_df$family <- factor(taxa_df$family)
taxa_df$genus <- factor(taxa_df$genus)

# CREATING COORDINATE ONLY DATA FRAME 
coordinate_only_df <- subset(specimens_df, max_ma != "NA")
write_csv(coordinate_only_df, "coordinate_only_data.csv")

# MERGING DATASETS BASED ON ACCEPTED NAME
master_df <- merge(specimens_df, taxa_df, by.x="accepted_name", by.y = "accepted_name")
write_csv(master_df, "combined_coordinate_extant_data.csv")

# CREATING NO COORDINATES DATA FRAME
no_coordinates_df <- subset(master_df, is.na(master_df$max_ma))


library(dplyr)
no_coordinates_df <- distinct(no_coordinates_df, accepted_name, .keep_all = TRUE)
write_csv(no_coordinates_df, "no_coordinates_data.csv")






























