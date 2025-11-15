SELECT
    o.row_id AS order_key,
    c.customer_id,
    p.product_key,
    r.region,
    d.date_id AS order_date,
    o.sales,
    o.quantity,
    o.discount,
    o.profit
FROM "sales_warehouse"."public"."stg_orders" o
LEFT JOIN "sales_warehouse"."public"."dim_customer" c ON o.customer_id = c.customer_id
LEFT JOIN "sales_warehouse"."public"."dim_product" p ON o.product_key = p.product_key
LEFT JOIN "sales_warehouse"."public"."dim_region" r ON o.region_key = r.region_key
LEFT JOIN "sales_warehouse"."public"."dim_date" d ON o.order_date = d.date_id