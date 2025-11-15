-- On crée une table de dates à partir des dates de commandes
SELECT DISTINCT
    order_date AS date_id,
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    EXTRACT(DAY FROM order_date) AS day
FROM "sales_warehouse"."public"."stg_orders"
WHERE order_date IS NOT NULL