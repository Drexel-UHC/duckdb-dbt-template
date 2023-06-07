{{ config(materialized='external', format =  target.schema) }}
with 

cte_1 as (
  select 
    *,
    from 
      (
      select * from {{ref('DEATH_PA_2010')}}
      union
      select * from {{ref('DEATH_PA_2015')}}
    )
)


 
SELECT 
  record_id, 
  state,
  year_of_death as year,
  zcta_of_death,
  zcta_of_residence,
  age_at_death, 
  gender,
  cause_of_death AS dx_code
FROM cte_1

