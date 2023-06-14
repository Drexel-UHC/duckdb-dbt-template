create or replace view "parquet"."DEATH_PA_2015__dbt_int" as (
        select * from '.\external-dev\models\/DEATH_PA_2015.parquet'
    );