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

# get package
package <- show_package("a7ae08f3-c512-4a88-bb3c-ab40eca50c5e")
package

# get all resources for this package
resources <- list_package_resources("a7ae08f3-c512-4a88-bb3c-ab40eca50c5e")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()

#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(data, "data/raw_data/raw_data.csv") 

         
