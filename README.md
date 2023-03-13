# INTRODUCTION	
This project looks at overall spatial trends in primate evolution. 

# DATA ACQUISITION
On March 3rd, 2023, data was downloaded from https://paleobiodb.org/#/. There were two downloaded spreadsheets: one focused on specimens and another focused on taxa. The specimen download contained some coordinate information, primarily regarding specimens found in the U.S., which was why both were downloaded. I deleted columns irrelevant columns, but these were the only changes made to the "accepted_primates_edit.csv" file. This file and the unedited coordinate file spreadsheets were imported into R were they were merged together based on accepted name. I downloaded a .csv file which included all entries and a separate .csv file which contained only the entries which had coordinate values associated. 
