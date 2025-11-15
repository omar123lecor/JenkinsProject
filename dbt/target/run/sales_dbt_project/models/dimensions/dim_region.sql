
  create view "sales_warehouse"."public"."dim_region__dbt_tmp"
    
    
  as (
    SELECT DISTINCT
    region,
    country,
    state,
    city,
    postal_code,
    postal_code || '-' || city AS region_key
FROM "sales_warehouse"."public"."stg_orders"
  );