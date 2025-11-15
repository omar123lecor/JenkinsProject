select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select postal_code
from "sales_warehouse"."public"."dim_region"
where postal_code is null



      
    ) dbt_internal_test