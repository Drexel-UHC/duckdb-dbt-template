{{ config(materialized='external', format =  target.schema) }}

select 
  *,
  dx_code IN ('D2463', 'D2511') AS flag_huff_pox
from {{ref('int__hosp')}}
