
  create view "sales_warehouse"."public"."dim_customer__dbt_tmp"
    
    
  as (
    SELECT DISTINCT
    customer_id,
    customer_name,
    segment
FROM "sales_warehouse"."public"."stg_orders"
  );