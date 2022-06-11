select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from vietlot_power655.mart.dim_date
where date_key is null



      
    ) dbt_internal_test