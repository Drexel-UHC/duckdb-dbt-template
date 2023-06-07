{{ config(materialized='external', format =  target.schema) }}

select 
   zcta, COUNT(*) AS n_huf_pox_death
from {{ref('int__huf_pox__mortality')}}
where flag_huff_pox = 'T'
group by zcta