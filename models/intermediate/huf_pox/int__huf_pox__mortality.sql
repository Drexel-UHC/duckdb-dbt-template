{{ config(materialized='external', format =  target.schema) }}

select 
  *,
  {{dx_huff_pox()}} AS flag_huff_pox,
from {{ref('int__mortality')}}
