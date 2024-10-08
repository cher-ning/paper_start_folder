#### Preamble ####
# Purpose: Simulates data
# Author: Cher Ning-Li
# Date: 24 September 2024
# Contact: cher.ning@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(304)

# Define the start and end date
start_date <- as.Date("2024-01-01")
end_date <- as.Date("2024-09-26")

# Set the number of random dates you want to generate
number_of_dates <- 100

simulated_data <-
  tibble(
    dates = as.Date(
      runif(
        n = number_of_dates,
        min = as.numeric(start_date),
        max = as.numeric(end_date)
      ),
      origin = "1970-01-01"
    ),
    actual_capacity = rpois(n = number_of_dates, lambda = 50),
    funding_capacity = max(rpois(n = number_of_dates, lambda = 50), 
                           rpois(n = number_of_dates, lambda = 60)),
    occupied = min(actual_capacity, rpois(n = number_of_dates, lambda = 50)),
    unoccupied = actual_capacity - occupied,
    unavailable = funding_capacity - actual_capacity,
    occupancy_rate = round((occupied/actual_capacity) *100, 2)
  )

# Write csv
write_csv(simulated_data, file = "data/raw_data/simulated.csv")
