{{ config(materialized='external', format =  target.schema) }}

WITH huf_pox_deaths AS (
    SELECT *
    FROM {{ ref('int__huf_pox__death_zcta_count') }}
),

huf_pox_hosp AS (
    SELECT *
    FROM {{ ref('int__huf_pox__hosp_zcta_count') }}
)

SELECT *
FROM huf_pox_hosp
JOIN huf_pox_deaths
ON huf_pox_hosp.zcta = huf_pox_deaths.zcta
