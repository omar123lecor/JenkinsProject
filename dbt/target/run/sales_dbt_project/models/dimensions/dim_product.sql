
  create view "sales_warehouse"."public"."dim_product__dbt_tmp"
    
    
  as (
    SELECT DISTINCT
    product_key || '-' || product_name AS product_key,
    category,
    sub_category,
    product_name
FROM "sales_warehouse"."public"."stg_orders"
  );