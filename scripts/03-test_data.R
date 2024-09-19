#### Preamble ####
# Purpose: Tests data
# Author: Cher Ning-Li
# Date: 19 September 2024
# Contact: cher.ning@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have data downloaded and cleaned
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)

#### Test data ####
data <- read_csv("data/raw_data/simulated.csv")

# Test there are no negative number of marriages
data$number_of_marriage |> min() <= 0

# Test for NAs
all(is.na(data$number_of_marriage))