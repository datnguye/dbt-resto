

with meet_condition as (
    select * from vietlot_power655.staging.staging_power655_box_detail where 1=1
)

select
    *
from meet_condition

where not(prize_won >= 0)

