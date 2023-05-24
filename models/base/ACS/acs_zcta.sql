{{ config(materialized='external', format =  target.schema) }}
SELECT *
FROM {{ source('ACS', 'acs_zcta') }}