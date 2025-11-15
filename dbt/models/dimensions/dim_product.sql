SELECT DISTINCT
    product_key || '-' || product_name AS product_key,
    category,
    sub_category,
    product_name
FROM {{ ref('stg_orders') }}
