
    
    

select
    box_id as unique_field,
    count(*) as n_records

from vietlot_power655.staging.staging_power655_box
where box_id is not null
group by box_id
having count(*) > 1


