select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    prize_key as unique_field,
    count(*) as n_records

from vietlot_power655.mart.dim_prize
where prize_key is not null
group by prize_key
having count(*) > 1



      
    ) dbt_internal_test