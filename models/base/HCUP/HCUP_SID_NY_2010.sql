{{ config(materialized='external', format =  target.schema) }}
SELECT *
FROM {{ source('HCUP', 'HCUP_SID_NY_2010') }}