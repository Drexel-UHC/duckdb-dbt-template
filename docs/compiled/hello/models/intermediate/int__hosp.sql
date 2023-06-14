
with 

cte_1 as (
  select 
    *,
    from 
      (
      select * from "main"."parquet"."HOSPITALIZATION_NY_2010"
      union
      select * from "main"."parquet"."HOSPITALIZATION_NY_2015"
      union
      select * from "main"."parquet"."HOSPITALIZATION_PA_2010"
      union
      select * from "main"."parquet"."HOSPITALIZATION_PA_2015"
    )
)


 
SELECT 
  patient_id, 
  state,
  year,
  zcta,
  age, 
  gender,
  diagnosis_code AS dx_code, 
  total_charges
FROM cte_1