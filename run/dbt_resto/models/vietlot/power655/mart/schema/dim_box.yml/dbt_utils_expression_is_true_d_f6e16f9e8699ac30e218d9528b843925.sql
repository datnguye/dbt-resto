select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      

with meet_condition as (
    select * from vietlot_power655.mart.dim_box where 1=1
)

select
    *
from meet_condition

where not(box_result_number_5 != box_result_number_6)


      
    ) dbt_internal_test