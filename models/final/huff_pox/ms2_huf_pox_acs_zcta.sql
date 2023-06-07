{{ config(materialized='external', format =  target.schema) }}

SELECT z.zcta, c.year, c.state, z.pct_nbblack, z.income, z.poverty_rate, z.population, c.n_huf_pox_hosp, c.n_huf_pox_death
FROM {{ref('int__huf_pox__hosp_death_zcta_year_counts')}} c
LEFT JOIN {{ref('acs_zcta')}} z ON z.zcta=c.zcta