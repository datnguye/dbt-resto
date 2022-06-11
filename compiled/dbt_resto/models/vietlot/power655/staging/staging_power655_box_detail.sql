

select  md5(cast(coalesce(cast(box_id as 
    varchar
), '') || '-' || coalesce(cast(value:prize_name as 
    varchar
), '') as 
    varchar
)) as sk_box_detail
        ,box_id
        ,cast(value:prize_name as 
    varchar
) as prize_name
        ,cast(value:prize_won as 
    int
) as prize_won
        ,cast(value:prize_value_raw as 
    varchar
) as prize_value_raw
        ,cast(value:prize_value as 
    float
) as prize_value

from    vietlot_power655.landing.power655_data
        ,lateral flatten(input => try_parse_json(box_results))

