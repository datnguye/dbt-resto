
    
    

select
    sk_box_detail as unique_field,
    count(*) as n_records

from vietlot_power655.staging.staging_power655_box_detail
where sk_box_detail is not null
group by sk_box_detail
having count(*) > 1


