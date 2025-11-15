SELECT DISTINCT
    region,
    country,
    state,
    city,
    postal_code,
    postal_code || '-' || city AS region_key
FROM "sales_warehouse"."public"."stg_orders"