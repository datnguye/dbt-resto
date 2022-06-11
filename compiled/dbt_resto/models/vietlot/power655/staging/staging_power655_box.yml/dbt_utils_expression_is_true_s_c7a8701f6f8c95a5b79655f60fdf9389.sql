

with meet_condition as (
    select * from vietlot_power655.staging.staging_power655_box where 1=1
)

select
    *
from meet_condition

where not(box_result_number_6 <= 56)

