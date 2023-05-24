{{ config(materialized='external', format =  target.schema) }}
SELECT *
FROM {{ source('Mortality', 'DEATH_PA_2010') }}