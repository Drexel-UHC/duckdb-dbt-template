{{ config(materialized='external', format =  target.schema) }}
SELECT *
FROM {{ source('HCUP', 'HCUP_SID_PA_2010') }}