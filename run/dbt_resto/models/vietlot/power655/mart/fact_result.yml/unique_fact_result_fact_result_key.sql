select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    fact_result_key as unique_field,
    count(*) as n_records

from vietlot_power655.mart.fact_result
where fact_result_key is not null
group by fact_result_key
having count(*) > 1



      
    ) dbt_internal_test