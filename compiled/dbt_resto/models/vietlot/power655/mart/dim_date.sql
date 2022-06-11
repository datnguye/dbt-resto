

select     box_date as date_key
          ,box_date
          ,
    

  date_part(day, box_date)


 as box_day
          ,
    

  date_part(week, box_date)


 as box_week
          ,
    

  date_part(month, box_date)


 as box_month
          ,substring(
            'Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec ',
            (
    

  date_part(month, box_date)


 * 4) - 3, 3) as box_month_name
          ,
    

  date_part(year, box_date)


 as box_year

from      vietlot_power655.staging.staging_power655_box

where     1 = 1


  and     box_date > coalesce((select max(box_date) from vietlot_power655.mart.dim_date), '1900-01-01')

