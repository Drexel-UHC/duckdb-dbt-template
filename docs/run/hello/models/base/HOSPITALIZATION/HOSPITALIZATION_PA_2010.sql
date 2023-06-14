create or replace view "parquet"."HOSPITALIZATION_PA_2010__dbt_int" as (
        select * from '.\external-dev\models\/HOSPITALIZATION_PA_2010.parquet'
    );