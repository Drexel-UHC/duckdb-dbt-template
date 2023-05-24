{{ config(materialized='external', format =  target.schema) }}
SELECT *
FROM {{ source('NETS', 'NETS') }}