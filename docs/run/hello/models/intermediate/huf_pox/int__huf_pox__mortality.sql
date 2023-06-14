create or replace view "parquet"."int__huf_pox__mortality__dbt_int" as (
        select * from '.\external-dev\models\/int__huf_pox__mortality.parquet'
    );