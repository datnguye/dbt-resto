

with meet_condition as (
    select * from vietlot_power655.mart.fact_number where 1=1
)

select
    *
from meet_condition

where not(occurrence_pos_4 <= occurrence)

