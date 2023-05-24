#' SImulates HCUP data
#' 


simulate_hcup_data <- function(year, state, n = 1000) {
  
  
  set.seed(123)
  
  data <- data.frame(
    Year = rep(year, n),
    State = rep(state, n),
    Patient_ID = seq(1:n),
    Age = round(rnorm(n, mean=50, sd=18)),
    Gender = sample(c("Male", "Female"), n, replace = TRUE),
    Length_of_Stay = round(rnorm(n, mean=4, sd=2)),
    Diagnosis_Code = sample(paste("D", sprintf("%04d",1:9999), sep = ""), n, replace = TRUE),
    Total_Charges = round(rnorm(n, mean=20000, sd=10000))
  )
  
  # Ensure age and length of stay are not negative, total charges are not negative
  data$Age[data$Age < 0] <- abs(data$Age[data$Age < 0])
  data$Length_of_Stay[data$Length_of_Stay < 0] <- abs(data$Length_of_Stay[data$Length_of_Stay < 0])
  data$Total_Charges[data$Total_Charges < 0] <- abs(data$Total_Charges[data$Total_Charges < 0])
  
  return(data)
}
