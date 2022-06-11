select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    box_name as unique_field,
    count(*) as n_records

from vietlot_power655.staging.staging_power655_box
where box_name is not null
group by box_name
having count(*) > 1



      
    ) dbt_internal_test