create or replace view "parquet"."NETS__dbt_int" as (
        select * from '.\external-dev\models\/NETS.parquet'
    );