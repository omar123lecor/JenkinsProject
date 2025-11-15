select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select quantity
from "sales_warehouse"."public"."fact_orders"
where quantity is null



      
    ) dbt_internal_test