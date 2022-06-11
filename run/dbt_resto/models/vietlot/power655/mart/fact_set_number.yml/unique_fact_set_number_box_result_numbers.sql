select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    box_result_numbers as unique_field,
    count(*) as n_records

from vietlot_power655.mart.fact_set_number
where box_result_numbers is not null
group by box_result_numbers
having count(*) > 1



      
    ) dbt_internal_test