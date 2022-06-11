select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with all_values as (

    select
        prize_name as value_field,
        count(*) as n_records

    from vietlot_power655.staging.staging_power655_box_detail
    group by prize_name

)

select *
from all_values
where value_field not in (
    'Jackpot 1','Jackpot 2','Giải nhất','Giải nhì','Giải ba'
)



      
    ) dbt_internal_test