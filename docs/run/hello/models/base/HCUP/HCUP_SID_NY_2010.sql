create or replace view "parquet"."HCUP_SID_NY_2010__dbt_int" as (
        select * from '.\external-dev\models\/HCUP_SID_NY_2010.parquet'
    );