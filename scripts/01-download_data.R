#### Preamble ####
# Purpose: Downloads and saves the data from Toronto Open Data
# Author: Cher Ning-Li
# Date: 24 September 2024
# Contact: cher.ning@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(opendatatoronto)
library(dplyr)
library(tidyverse)
# package to use write_csv
library(readr)

# package <- show_package("21c83b32-d5a8-4106-a54f-010dbe49f6f2")

# accesses link directly to download full data file
all_data <- read_csv("https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/21c83b32-d5a8-4106-a54f-010dbe49f6f2/resource/ffd20867-6e3c-4074-8427-d63810edf231/download/Daily%20shelter%20overnight%20occupancy.csv")

#### Save data ####
write_csv(all_data, "data/raw_data/raw_data.csv")
