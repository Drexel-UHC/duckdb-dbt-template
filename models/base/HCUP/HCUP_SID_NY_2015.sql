{{ config(materialized='external', format =  target.schema) }}
SELECT *
FROM {{ source('HCUP', 'HOSPITALIZATION_NY_2015') }}