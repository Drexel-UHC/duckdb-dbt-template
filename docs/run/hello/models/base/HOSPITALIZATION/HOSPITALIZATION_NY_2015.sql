create or replace view "parquet"."HOSPITALIZATION_NY_2015__dbt_int" as (
        select * from '.\external-dev\models\/HOSPITALIZATION_NY_2015.parquet'
    );