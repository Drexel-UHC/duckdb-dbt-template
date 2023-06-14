create or replace view "parquet"."int__hospitalization__dbt_int" as (
        select * from '.\external-dev\models\/int__hospitalization.parquet'
    );