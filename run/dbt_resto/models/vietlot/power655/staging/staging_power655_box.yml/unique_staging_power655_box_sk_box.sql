select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    sk_box as unique_field,
    count(*) as n_records

from vietlot_power655.staging.staging_power655_box
where sk_box is not null
group by sk_box
having count(*) > 1



      
    ) dbt_internal_test