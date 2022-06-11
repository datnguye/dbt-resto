select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with all_values as (

    select
        is_prize_taken as value_field,
        count(*) as n_records

    from vietlot_power655.mart.fact_result
    group by is_prize_taken

)

select *
from all_values
where value_field not in (
    '0','1'
)



      
    ) dbt_internal_test