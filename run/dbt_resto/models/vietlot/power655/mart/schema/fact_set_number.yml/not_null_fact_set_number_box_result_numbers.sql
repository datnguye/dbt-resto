select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from vietlot_power655.mart.fact_set_number
where box_result_numbers is null



      
    ) dbt_internal_test