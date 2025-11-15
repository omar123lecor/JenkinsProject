-- Standardisation et typage correct des données brutes
SELECT
    CAST(Row_ID AS INTEGER) AS row_id,
    Order_ID AS order_id,
    CAST(Order_Date AS DATE) AS order_date,
    CAST(Ship_Date AS DATE) AS ship_date,
    Ship_Mode AS ship_mode,
    Customer_ID AS customer_id,
    Customer_Name AS customer_name,
    Segment AS segment,
    Country AS country,
    City AS city,
    State AS state,
    Postal_Code AS postal_code,  -- garder TEXT car certains codes postaux peuvent commencer par 0
    postal_code || '-' || city AS region_key,
    Region AS region,
    product_id || '-' || product_name AS product_key,
    Category AS category,
    Sub_Category AS sub_category,
    Product_Name AS product_name,
    CAST(Sales AS NUMERIC(10,2)) AS sales,
    CAST(Quantity AS INTEGER) AS quantity,
    CAST(Discount AS NUMERIC(5,2)) AS discount,
    CAST(Profit AS NUMERIC(10,2)) AS profit
FROM public.sales