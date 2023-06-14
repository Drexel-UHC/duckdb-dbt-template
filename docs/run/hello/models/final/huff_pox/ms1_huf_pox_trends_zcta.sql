create or replace view "parquet"."ms1_huf_pox_trends_zcta__dbt_int" as (
        select * from '.\external-dev\models\/ms1_huf_pox_trends_zcta.parquet'
    );