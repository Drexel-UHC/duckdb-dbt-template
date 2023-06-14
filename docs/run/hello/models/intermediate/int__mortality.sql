create or replace view "parquet"."int__mortality__dbt_int" as (
        select * from '.\external-dev\models\/int__mortality.parquet'
    );