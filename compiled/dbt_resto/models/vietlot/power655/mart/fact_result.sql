

select   md5(cast(coalesce(cast(b.sk_box as 
    varchar
), '') || '-' || coalesce(cast(bd.prize_name as 
    varchar
), '') || '-' || coalesce(cast(b.box_date as 
    varchar
), '') as 
    varchar
))
         as fact_result_key
        ,b.sk_box as box_key
        , md5(cast(coalesce(cast(bd.prize_name as 
    varchar
), '') as 
    varchar
))
         as prize_key
        ,b.box_date as date_key
        ,bd.prize_won as no_of_won
        ,bd.prize_value as prize_value
        ,bd.prize_value * bd.prize_won as prize_paid
        ,case
          when bd.prize_won > 0 then 1
          else 0
        end as is_prize_taken

from    vietlot_power655.staging.staging_power655_box as b
join    vietlot_power655.staging.staging_power655_box_detail as bd
  on    bd.box_id = b.box_id

where   1 = 1



  and   b.box_date > coalesce((select max(date_key) from vietlot_power655.mart.fact_result), '1900-01-01')

