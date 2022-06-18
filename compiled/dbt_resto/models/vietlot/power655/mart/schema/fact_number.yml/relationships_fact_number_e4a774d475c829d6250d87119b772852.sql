
    
    

with child as (
    select last_appearance_pos_1 as from_field
    from (select * from vietlot_power655.mart.fact_number where last_appearance_pos_1 is not null) dbt_subquery
    where last_appearance_pos_1 is not null
),

parent as (
    select date_key as to_field
    from vietlot_power655.mart.dim_date
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


