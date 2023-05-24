
# Define a function to generate spatial data
generate_spatial_data <- function(state, n = 1000) {
  
  set.seed(123)
  
  data <- data.frame(
    State = rep(state, n),
    ZCTA = sample(sprintf("%05d",1:99999), n, replace = TRUE),
    County_Code = sample(sprintf("%03d",1:999), n, replace = TRUE),
    City_Name = sample(c("Everwood Springs", "Silverstone Ridge", "Coppermill Valley", "Liberty Meadows", 
                         "Fox Hollow", NA, NA, NA, NA, NA), n, replace = TRUE)
  )
 
  final =  data %>% 
    clean_names() %>% 
    as_tibble() 
  
  return(final)
}

# Generate spatial data for PA and NY
PA_spatial_data <- generate_spatial_data("PA")
NY_spatial_data <- generate_spatial_data("NY")

# Combine all the data
final_spatial_data = rbind(PA_spatial_data, NY_spatial_data) %>% 
  mutate(state_fip = ifelse(state=='PA','11','12'),
         county = paste0(state_fip, county_code)) %>% 
  rename(city = city_name) %>% 
  select(zcta, county, city, state)

# Write the final data to a csv file
final_spatial_data %>% write.csv("clean/spatial_relationships.csv", row.names = FALSE)
final_spatial_data %>% write_parquet("clean/spatial_relationships.parquet")
