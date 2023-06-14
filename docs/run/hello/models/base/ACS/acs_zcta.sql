create or replace view "parquet"."acs_zcta__dbt_int" as (
        select * from '.\external-dev\models\/acs_zcta.parquet'
    );