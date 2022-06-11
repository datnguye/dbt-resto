select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from vietlot_power655.staging.staging_power655_box_detail
where sk_box_detail is null



      
    ) dbt_internal_test