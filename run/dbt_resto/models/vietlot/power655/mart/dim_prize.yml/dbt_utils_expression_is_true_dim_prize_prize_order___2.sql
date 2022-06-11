select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      

with meet_condition as (
    select * from (select * from vietlot_power655.mart.dim_prize where prize_name = 'Jackpot 2') dbt_subquery where 1=1
)

select
    *
from meet_condition

where not(prize_order = 2)


      
    ) dbt_internal_test