{ # Setup -------------------------------------------------------------------

  ## Dependencies
  library(dplyr)
  library(tidyr)
  library(purrr)
  library(glue)
  library(arrow)
  library(cli)
  library(janitor)
  library(stringr)

  ## Imports
  source("R/export_dataset.R")
  xwalk_spatial = read_parquet("clean/spatial_relationships.parquet")
}


{ # Simulate data -----------------------------------------------------------

  "code/simulation/zcta-county-place.R"
  "code/simulation/hcup.R"
  "code/simulation/pa_death.R"
  "code/simulation/nets.R"
  "code/simulation/acs.R"
  
}


