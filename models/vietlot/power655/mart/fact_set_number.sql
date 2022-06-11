with staging_box as (

  select * from {{ ref('staging_power655_box') }}

)

select     box_result_numbers
          ,count(1) as occurrence
          ,max(box_date) as last_appearance

from      staging_box

group by  box_result_numbers