#### Preamble ####
# Purpose: Tests data
# Author: Cher Ning-Li
# Date: 27 September 2024
# Contact: cher.ning@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have data downloaded and cleaned
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)

#### Test data ####
data <- read_csv("data/analysis_data/analysis_data.csv")

# Tests class of columns are what we expect
expect_equal(class(data$date), "Date") 
#data$date |> class() <= "Date"
data$month |> class() <= "numeric"
data$actual_capacity |> class() <= "numeric"
data$funding_capacity |> class() <= "numeric"
data$occupied_beds |> class() <= "numeric"
data$unoccupied_beds |> class() <= "numeric"
data$unavailable_beds |> class() <= "numeric"
data$occupancy_rate |> class() <= "numeric"
data$fsa |> class() <= "character"

# Test for absence of negative numbers in capacity_funding_bed
data$funding_capacity |> min() >= 0

# Test that occupancy_rate is between 0-100
data$occupancy_rate |> max() <= 100  
data$occupancy_rate |> max() >= 0

# Tests that dataset assumption of 
# funding_capacity = occupied_beds + unoccupied_beds + unavailable_beds holds
all(data$funding_capacity - data$occupied_beds - data$unoccupied_beds - 
  data$unavailable_beds == 0)

all(data$funding_capacity == data$actual_capacity + data$unavailable_beds)

