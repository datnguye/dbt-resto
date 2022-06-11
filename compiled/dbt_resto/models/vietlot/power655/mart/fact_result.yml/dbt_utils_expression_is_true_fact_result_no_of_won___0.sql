

with meet_condition as (
    select * from vietlot_power655.mart.fact_result where 1=1
)

select
    *
from meet_condition

where not(no_of_won >= 0)

