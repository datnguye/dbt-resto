

with meet_condition as (
    select * from (select * from vietlot_power655.mart.fact_result where no_of_won > 0) dbt_subquery where 1=1
)

select
    *
from meet_condition

where not(is_prize_taken = 1)

