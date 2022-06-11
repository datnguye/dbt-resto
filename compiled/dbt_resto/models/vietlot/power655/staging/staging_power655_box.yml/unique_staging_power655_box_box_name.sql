
    
    

select
    box_name as unique_field,
    count(*) as n_records

from vietlot_power655.staging.staging_power655_box
where box_name is not null
group by box_name
having count(*) > 1


