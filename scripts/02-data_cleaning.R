#### Preamble ####
# Purpose: Cleans the raw shelter data for only relevant variables
# Author: Cher Ning-Li
# Date: 19 September 2024
# Contact: cher.ning@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to have downloaded data
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_data.csv")

# filters for only Bed Based and Emergency type shelters located in Toronto
filtered <- subset(raw_data, CAPACITY_TYPE == 'Bed Based Capacity' &
                     PROGRAM_MODEL == 'Emergency' & LOCATION_CITY == 'Toronto')

# filters out negative numbers in numeric columns
filtered <- filtered[filtered$UNOCCUPIED_BEDS >=0, ]
filtered <- filtered[filtered$OCCUPIED_BEDS >=0, ]
filtered <- filtered[filtered$CAPACITY_ACTUAL_BED >=0, ]
filtered <- filtered[filtered$CAPACITY_FUNDING_BED >=0, ]
filtered <- filtered[filtered$UNAVAILABLE_BEDS >=0, ]
filtered <- filtered[filtered$OCCUPANCY_RATE_BEDS >=0, ]
filtered <- filtered[filtered$OCCUPANCY_RATE_BEDS <= 100, ]

# adds column for month + fsa (first 3 digits of postal code) for later analysis
filtered$month <- as.numeric(format(as.Date(filtered$OCCUPANCY_DATE), "%m"))
filtered$fsa <- substr(filtered$LOCATION_POSTAL_CODE, start=1, stop=3)


# removes unnecessarily variables
filtered <- filtered %>% select('_id', month, OCCUPANCY_DATE, fsa, LOCATION_ID, 
                                CAPACITY_ACTUAL_BED, CAPACITY_FUNDING_BED, 
                                OCCUPIED_BEDS, UNOCCUPIED_BEDS, 
                                UNAVAILABLE_BEDS, OCCUPANCY_RATE_BEDS)

# removes NA data entries
filtered <- filtered %>% drop_na()

# removes rows with NA data, cleans column names for more concision
cleaned_data <- filtered %>% janitor::clean_names()
cleaned_data <- rename(cleaned_data, date = occupancy_date)
cleaned_data <- rename(cleaned_data, actual_capacity = capacity_actual_bed)
cleaned_data <- rename(cleaned_data, funding_capacity = capacity_funding_bed)
cleaned_data <- rename(cleaned_data, occupancy_rate = occupancy_rate_beds)

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
