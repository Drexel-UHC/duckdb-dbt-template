

select 
   zcta, 
   year,
   state,
   COUNT(*) AS n_huf_pox_death
from "main"."parquet"."int__huf_pox__mortality"
where flag_huff_pox = 'T'
group by zcta, year, state