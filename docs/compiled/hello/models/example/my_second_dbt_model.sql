-- Use the `ref` function to select from other models

select *
from "main"."parquet"."my_first_dbt_model"
where id = 1