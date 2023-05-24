{ # Sim Data ----------------------------------------------------------------
  
  zcta_data = xwalk_spatial
  
  # Defining business types
  business_types <- c("Grocery Store", "Restaurant", "Gas Station", "Hardware Store", 
                      "Clothing Store", "Pharmacy", "Electronics Store")
  
  # Creating the simulated business data
  set.seed(123) # for reproducibility
  business_data <- zcta_data %>%
    rowwise() %>%
    mutate(n = ifelse(is.na(city), sample(1:5, size = 1), sample(5:10, size = 1))) %>%
    ungroup() %>%
    uncount(n) %>%
    mutate(
      business_name = paste("Business", sample(1:10000, size = n(), replace = TRUE)),
      business_type = sample(business_types, size = n(), replace = TRUE),
      num_employees = sample(1:100, size = n(), replace = TRUE),
      years_in_operation = sample(1:30, size = n(), replace = TRUE)
    ) 
  
  sim_data = business_data %>% 
    mutate(dataset = "NETS")
}

{ # Generate Metadata ------------------------------------------------------
  
  codebook <- data.frame(
    Variable = colnames(business_data),
    Description = c("Name of the business", "Type of business", 
                    "Number of employees", "Years in operation"),
    Type = c("Character", "Factor", "Numeric", "Numeric"),
    Values = c("Business 1 to Business 10000", 
              paste(business_types, collapse = ", "),
              "1 to 100", 
              "1 to 30")
  ) %>% 
    as_tibble()%>% 
    clean_names() %>% 
    mutate(variable = str_to_lower(variable))
  
  # Write the codebook to a csv file
  write.csv(codebook,  glue("clean/metadata/nets_metadata.csv"), row.names = FALSE)
}

{ # Export ------------------------------------------------------------------
  export_dataset(sim_data)
}


{ # EDA ---------------------------------------------------------------------
  
  dfa = sim_data
  
  
  dfa %>% count(business_type)
  
}


