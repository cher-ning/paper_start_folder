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
filtered <- subset(data, CAPACITY_TYPE == 'Bed Based Capacity' &
                     PROGRAM_MODEL == 'Emergency' & LOCATION_CITY == 'Toronto')

# removes unnecessarily variables
filtered <- filtered %>% select(OCCUPANCY_DATE, SHELTER_ID, 
                                LOCATION_POSTAL_CODE, CAPACITY_ACTUAL_BED,
                                CAPACITY_FUNDING_BED, OCCUPIED_BEDS,
                                UNOCCUPIED_BEDS, UNAVAILABLE_BEDS, 
                                OCCUPANCY_RATE_BEDS)

# removes rows with NA data
cleaned_data <- filtered %>% drop_na()

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
