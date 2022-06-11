select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from vietlot_power655.staging.staging_power655_box
where box_result_number_3 is null



      
    ) dbt_internal_test