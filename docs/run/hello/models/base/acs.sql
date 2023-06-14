create or replace view "parquet"."acs__dbt_int" as (
        select * from '.\external-dev\models\/acs.parquet'
    );