{ # Simulate ----------------------------------------------------------------

  # Define the vector of ZCTAs
  zcta <- xwalk_spatial$zcta
  
  # Set the seed for reproducibility
  set.seed(123)
  
  # Define the number of ZCTAs
  n <- length(zcta)
  
  # Create a data frame with demographic statistics for each ZCTA
  acs_data <- data.frame(
    zcta = zcta,
    pct_nhwhite = runif(n, 0, 100),  # Uniformly distributed percentages
    pct_nbblack = runif(n, 0, 100),  # Uniformly distributed percentages
    pct_hispanic = runif(n, 0, 100), # Uniformly distributed percentages
    income = rnorm(n, 50000, 10000),  # Normally distributed income, mean = 50000, sd = 10000
    poverty_rate = runif(n, 0, 100),  # Uniformly distributed percentages
    population = round(runif(n, 1000, 50000))  # Uniformly distributed population size between 1000 and 50000
  ) %>% 
    as_tibble() 
  
}

{# Metadata ----------------------------------------------------------------

  # Create a codebook data frame
  codebook <- data.frame(
    Variable = colnames(acs_data),
    Description = c(
      "Zip Code Tabulation Area",
      "Percent of Non-Hispanic White population",
      "Percent of Non-Black population",
      "Percent of Hispanic population",
      "Average Income",
      "Poverty Rate",
      "Total Population"
    ),
    Type = c(
      "Numeric", 
      "Numeric", 
      "Numeric", 
      "Numeric", 
      "Numeric", 
      "Numeric", 
      "Numeric"
    ),
    Values = c(
      paste0(zcta, collapse = ", "),
      "0 to 100", 
      "0 to 100", 
      "0 to 100", 
      "Variable (in US Dollars)", 
      "0 to 100", 
      "Variable (Number of Individuals)"
    )
  ) %>% 
    as_tibble() %>% 
    clean_names() %>% 
    mutate(variable = str_to_lower(variable))
  
  # Write the codebook to a csv file
  write.csv(codebook,  glue("clean/metadata/acs_metadata.csv"), row.names = FALSE)
  
  
}


{ # Export ------------------------------------------------------------------
  
  sim_data = acs_data %>%  mutate(dataset = "ACS") 
  
  export_dataset(sim_data)
}
