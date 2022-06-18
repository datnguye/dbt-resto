select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    box_key as unique_field,
    count(*) as n_records

from vietlot_power655.mart.dim_box
where box_key is not null
group by box_key
having count(*) > 1



      
    ) dbt_internal_test