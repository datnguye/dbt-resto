

with meet_condition as (
    select * from (select * from vietlot_power655.mart.dim_prize where prize_name = 'Giải ba') dbt_subquery where 1=1
)

select
    *
from meet_condition

where not(prize_order = 5)

