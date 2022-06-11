

with meet_condition as (
    select * from vietlot_power655.mart.dim_box where 1=1
)

select
    *
from meet_condition

where not(box_result_number_3 != box_result_number_4)

