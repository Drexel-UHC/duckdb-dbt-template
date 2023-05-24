{ # Setup -------------------------------------------------------------------

  # Define a function to generate data
  simulate_hcup_data <- function(template_row, n = 10^5) {
    
    
    set.seed(123)
    
    state = template_row$state
    year = template_row$year
    dataset = template_row$dataset
    
    xwalk_tmp = xwalk_spatial %>% filter(state == template_row$state)
    
    data <- data.frame(
      Year = rep(year, n),
      State = rep(state, n),
      Patient_ID = seq(1:n),
      zcta = sample(xwalk_spatial$zcta, size = n, replace = TRUE),
      Age = round(rnorm(n, mean=50, sd=18)),
      Gender = sample(c("Male", "Female"), n, replace = TRUE),
      Length_of_Stay = round(rnorm(n, mean=4, sd=2)),
      Diagnosis_Code = sample(paste("D", sprintf("%04d",1:9999), sep = ""), n, replace = TRUE),
      Total_Charges = round(rnorm(n, mean=20000, sd=10000)),
      Dataset = rep(dataset, n)
    )
    
    # Ensure age and length of stay are not negative, total charges are not negative
    data$Age[data$Age < 0] <- abs(data$Age[data$Age < 0])
    data$Length_of_Stay[data$Length_of_Stay < 0] <- abs(data$Length_of_Stay[data$Length_of_Stay < 0])
    data$Total_Charges[data$Total_Charges < 0] <- abs(data$Total_Charges[data$Total_Charges < 0])
    
    final = data %>% 
      as_tibble() %>% 
      clean_names()
    return(final)
  }
 
}

{ # Sim Data ----------------------------------------------------------------

  # combinations to generate
  states <- c("PA", "NY")
  years <- c(2010, 2015)
  template = crossing(state = states, year = years) %>% 
    mutate(dataset = glue("HCUP_SID_{state}_{year}"))
  
  # simualte
  sim_data = template %>% 
    group_by(row_number()) %>% 
    group_map(~simulate_hcup_data(.x))
}

{ # Generate Metadata ------------------------------------------------------

  
  # Define the codebook
  codebook <- tribble(
    ~Variable, ~Description, ~Type, ~Values,
    "year", "The year of the hospital stay", "Numeric", "2010, 2015",
    "zcta", "Five digit ZCTA code", 'Numeric','Five digit codes',
    "state", "The state where the hospital stay occurred", "Categorical", "NY, PA",
    "patient_id", "Unique identifier for each patient", "Numeric", "Range from 1 to the number of simulated patients",
    "age", "Age of the patient", "Numeric", "Simulated based on normal distribution (Mean = 50, SD = 18)",
    "gender", "Gender of the patient", "Categorical", "Male, Female",
    "length_of_stay", "Length of hospital stay in days", "Numeric", "Simulated based on normal distribution (Mean = 4, SD = 2)",
    "diagnosis_code", "The diagnosis code for the hospital stay", "Categorical", "Simulated codes from D0001 to D9999",
    "total_charges", "Total charges for the hospital stay", "Numeric", "Simulated based on normal distribution (Mean = 20000, SD = 10000)"
  )
  
  # Write the codebook to a csv file
  write.csv(codebook,  glue("clean/metadata/hcup_metadata.csv"), row.names = FALSE)
  
}

{ # Export ------------------------------------------------------------------
  
  walk(sim_data,
       function(data){
         dataset_id = unique(data$dataset)
         data %>% arrow::write_csv_arrow(sink = glue("clean/csv/{dataset_id}.csv"))
         data %>% arrow::write_parquet(sink = glue("clean/parquet/{dataset_id}.parquet"))
         cli_alert_success("Export simulated data: {dataset_id}")
         })
  
}


{ # EDA ---------------------------------------------------------------------

  dfa = sim_data %>% bind_rows()
  
  
  ## dx codes
  set.seed(123)
  flu_codes = dfa %>% count(diagnosis_code) %>% sample_n(6) %>% pull(diagnosis_code)
  cli_alert_info("simulate flu codes: {flu_codes}")
  
}
 

