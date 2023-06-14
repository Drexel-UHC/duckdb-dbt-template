create or replace view "parquet"."HOSPITALIZATION_PA_2015__dbt_int" as (
        select * from '.\external-dev\models\/HOSPITALIZATION_PA_2015.parquet'
    );