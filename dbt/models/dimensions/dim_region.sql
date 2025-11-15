SELECT DISTINCT
    region,
    country,
    state,
    city,
    postal_code,
    postal_code || '-' || city AS region_key
FROM {{ ref('stg_orders') }}
