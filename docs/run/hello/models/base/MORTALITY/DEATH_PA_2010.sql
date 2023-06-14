create or replace view "parquet"."DEATH_PA_2010__dbt_int" as (
        select * from '.\external-dev\models\/DEATH_PA_2010.parquet'
    );