#'
#'


export_dataset <- function(data){
  
  dataset_id = unique(data$dataset)
  data %>% arrow::write_csv_arrow(sink = glue("clean/csv/{dataset_id}.csv"))
  data %>% arrow::write_parquet(sink = glue("clean/parquet/{dataset_id}.parquet"))
  cli_alert_success("Export simulated data: {dataset_id}")
  
}
