create or replace view "parquet"."int__hosp__dbt_int" as (
        select * from '.\external-dev\models\/int__hosp.parquet'
    );