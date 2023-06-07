{{ config(materialized='external', format =  target.schema) }}
SELECT *
FROM {{ source('HCUP', 'HOSPITALIZATION_PA_2010') }}