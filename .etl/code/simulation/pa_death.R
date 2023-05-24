{ # Setup -------------------------------------------------------------------

  simulate_mortality_data <- function(template_row, n = 10^5) {
    
    set.seed(123)
    
    state = template_row$state
    year = template_row$year
    dataset = template_row$dataset
    
    data <- data.frame(
      Year_of_Death = rep(year, n),
      State = rep(state, n),
      Record_ID = seq(1:n),
      Age_at_Death = round(rnorm(n, mean=75, sd=10)),
      Gender = sample(c("Male", "Female"), n, replace = TRUE),
      Cause_of_Death = sample(paste("I", sprintf("%02d",0:99), sep = ""), n, replace = TRUE),
      ZCTA_of_Residence = sample(sprintf("%05d",1:99999), n, replace = TRUE),
      ZCTA_of_Death = sample(sprintf("%05d",1:99999), n, replace = TRUE),
      Dataset = rep(dataset, n)
    )
    
    # Ensure age is not negative
    data$Age_at_Death[data$Age_at_Death < 0] <- abs(data$Age_at_Death[data$Age_at_Death < 0])
    
    final = data %>% 
      as_tibble() %>% 
      janitor::clean_names()
    
    return(final)
  }
 
}

{ # Sim Data ----------------------------------------------------------------

  # combinations to generate
  states <- c("PA" )
  years <- c(2010, 2015)
  template = crossing(state = states, year = years) %>% 
    mutate(dataset = glue("DEATH_{state}_{year}"))
  
  # simualte
  sim_data = template %>% 
    group_by(row_number()) %>% 
    group_map(~simulate_mortality_data(.x))
}

{ # Generate Metadata ------------------------------------------------------

  
  # Define the codebook
  mortality_codebook <- tribble(
    ~Variable, ~Description, ~Type, ~Values,
    "Year_of_Death", "The year when the death occurred", "Numeric", "As specified in template row (e.g., 2010, 2015)",
    "State", "The state where the person was living at the time of death", "Categorical", "As specified in template row (e.g., 'PA')",
    "Record_ID", "Unique identifier for each record", "Numeric", "Range from 1 to the number of simulated records",
    "Age_at_Death", "Age of the person at the time of death", "Numeric", "Simulated based on normal distribution (Mean = 75, SD = 10)",
    "Gender", "Gender of the person", "Categorical", "Male, Female",
    "Cause_of_Death", "The cause of death represented by a simulated ICD-10 code", "Categorical", "Simulated codes from I00 to I99",
    "ZCTA_of_Residence", "ZIP Code Tabulation Area of residence", "Categorical", "Simulated 5-digit codes from 00001 to 99999",
    "ZCTA_of_Death", "ZIP Code Tabulation Area of death", "Categorical", "Simulated 5-digit codes from 00001 to 99999",
    "Dataset", "The dataset where the record comes from", "Categorical", "As specified in template row"
  ) %>% 
    clean_names() %>% 
    mutate(variable = str_to_lower(variable))
  
  # Write the codebook to a csv file
  write.csv(codebook,  glue("clean/metadata/pa_death_metadata.csv"), row.names = FALSE)
  
}

{ # Export ------------------------------------------------------------------
  walk(sim_data, ~export_dataset(.x))
}


{ # EDA ---------------------------------------------------------------------

  dfa = sim_data %>% bind_rows()
  
  
  ## dx codes
  set.seed(123)
  flu_codes = dfa %>% count(cause_of_death) %>% sample_n(6) %>% pull(cause_of_death)
  cli_alert_info("simulate cancer ICD10: {flu_codes}")
  
}
 

