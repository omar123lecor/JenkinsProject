select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select region_key
from "sales_warehouse"."public"."dim_region"
where region_key is null



      
    ) dbt_internal_test