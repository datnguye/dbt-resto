select  
          md5(cast(coalesce(cast(prize_name as 
    varchar
), '') as 
    varchar
))
         as prize_key
        ,prize_name
        ,case
          when prize_name = 'Jackpot 1' then 1
          when prize_name = 'Jackpot 2' then 2
          when prize_name = 'Giải nhất' then 3
          when prize_name = 'Giải nhì'  then 4
          when prize_name = 'Giải ba'   then 5
        end as prize_order

from    vietlot_power655.staging.staging_power655_box_detail
group by prize_name