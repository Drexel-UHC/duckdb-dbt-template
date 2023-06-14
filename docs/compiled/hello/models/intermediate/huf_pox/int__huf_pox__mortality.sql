

select 
  *,
  dx_code IN ('D2463', 'D2511') AS flag_huff_pox,
from "main"."parquet"."int__mortality"