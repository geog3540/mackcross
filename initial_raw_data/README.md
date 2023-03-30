# INTRODUCTION	
This project looks at overall spatial trends in primate evolution. 

# DATA ACQUISITION
On March 14th, 2023, data was downloaded from https://paleobiodb.org/#/. There were two downloaded spreadsheets: one focused on specimens and another focused on taxa. 

For the first spreadsheet, the following selections were made: 
1) "Specimens" was selected
2) In the "Select by taxonomy" option, "primates" was typed
3) In the "Choose output options" option, "reference", "coordinates" and "classification" were selected 
This downloaded file was saved as "specimens_original.csv." 

For the second spreadsheet, the following selections were made: 
1) "Taxa" was selected
2) In the "Select by taxonomy" option, "primates" was typed
3) In the "Select by taxonomy" option, "species" was selected for "Taxonomic rank(s):" 
4) In the "Choose output options" option, "reference" and "classification" were selected 
This downloaded file was saved as "taxa_original.csv." 

Both of these spreadsheets were used as the first spreadsheet contains some pre-existing coordinate data, while the second spreadsheet contains information on extinct/extant status. I imported these spreadsheets into R for cleaning. Please see .R file, which has the code used to clean with commented explanations. 

