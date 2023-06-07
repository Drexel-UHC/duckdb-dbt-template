{{ config(materialized='external', format =  target.schema) }}

SELECT DISTINCT m.zcta, m.year, m.state, m.n_huf_pox_death, h.n_huf_pox_hosp
FROM {{ref('int__huf_pox__death_zcta_count')}} m
FULL JOIN {{ref('int__huf_pox__hosp_zcta_count')}} h ON h.zcta=m.zcta AND h.year=h.year