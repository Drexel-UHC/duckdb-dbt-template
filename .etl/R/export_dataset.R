#'
#'


export_dataset <- function(sim_data){
  
  dataset_id = unique(sim_data$dataset)
  sim_data %>% arrow::write_csv_arrow(sink = glue("clean/csv/{dataset_id}.csv"))
  sim_data %>% arrow::write_parquet(sink = glue("clean/parquet/{dataset_id}.parquet"))
  cli_alert_success("Export simulated sim_data: {dataset_id}")
  
}
