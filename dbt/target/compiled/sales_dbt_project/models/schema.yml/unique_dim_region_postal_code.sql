
    
    

select
    postal_code as unique_field,
    count(*) as n_records

from "sales_warehouse"."public"."dim_region"
where postal_code is not null
group by postal_code
having count(*) > 1


