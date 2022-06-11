
    
    

select
    box_date as unique_field,
    count(*) as n_records

from vietlot_power655.staging.staging_power655_box
where box_date is not null
group by box_date
having count(*) > 1


