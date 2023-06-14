create or replace view "parquet"."HOSPITALIZATION_NY_2010__dbt_int" as (
        select * from '.\external-dev\models\/HOSPITALIZATION_NY_2010.parquet'
    );