create or replace view "parquet"."int__huf_pox__death_zcta_count__dbt_int" as (
        select * from '.\external-dev\models\/int__huf_pox__death_zcta_count.parquet'
    );