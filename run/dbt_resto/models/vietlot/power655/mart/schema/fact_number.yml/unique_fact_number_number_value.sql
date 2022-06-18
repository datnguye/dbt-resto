select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    number_value as unique_field,
    count(*) as n_records

from vietlot_power655.mart.fact_number
where number_value is not null
group by number_value
having count(*) > 1



      
    ) dbt_internal_test