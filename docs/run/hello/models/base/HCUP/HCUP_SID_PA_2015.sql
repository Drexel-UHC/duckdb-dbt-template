create or replace view "parquet"."HCUP_SID_PA_2015__dbt_int" as (
        select * from '.\external-dev\models\/HCUP_SID_PA_2015.parquet'
    );