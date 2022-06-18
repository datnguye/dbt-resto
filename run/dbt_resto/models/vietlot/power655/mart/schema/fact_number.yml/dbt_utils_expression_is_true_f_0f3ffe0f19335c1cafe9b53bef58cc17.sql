select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      

with meet_condition as (
    select * from vietlot_power655.mart.fact_number where 1=1
)

select
    *
from meet_condition

where not(occurrence_pos_2 <= occurrence)


      
    ) dbt_internal_test