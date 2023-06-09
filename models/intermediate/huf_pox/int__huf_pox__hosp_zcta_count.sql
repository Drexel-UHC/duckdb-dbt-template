{{ config(materialized='external', format =  target.schema) }}

select 
   zcta,
   state,
   year,
   COUNT(*) AS n_huf_pox_hosp
from {{ref('int__huf_pox__hosp')}}
where flag_huff_pox = 'T'
group by  year, state, zcta