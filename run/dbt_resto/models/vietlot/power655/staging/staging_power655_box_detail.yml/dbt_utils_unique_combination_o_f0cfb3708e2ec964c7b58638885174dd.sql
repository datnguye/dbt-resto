select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      





with validation_errors as (

    select
        box_id, prize_name
    from vietlot_power655.staging.staging_power655_box_detail
    group by box_id, prize_name
    having count(*) > 1

)

select *
from validation_errors



      
    ) dbt_internal_test