select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    box_id as unique_field,
    count(*) as n_records

from vietlot_power655.mart.dim_box
where box_id is not null
group by box_id
having count(*) > 1



      
    ) dbt_internal_test