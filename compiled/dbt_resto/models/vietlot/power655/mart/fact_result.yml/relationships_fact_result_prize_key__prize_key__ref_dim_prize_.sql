
    
    

with child as (
    select prize_key as from_field
    from vietlot_power655.mart.fact_result
    where prize_key is not null
),

parent as (
    select prize_key as to_field
    from vietlot_power655.mart.dim_prize
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


