select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    postal_code as unique_field,
    count(*) as n_records

from "sales_warehouse"."public"."dim_region"
where postal_code is not null
group by postal_code
having count(*) > 1



      
    ) dbt_internal_test