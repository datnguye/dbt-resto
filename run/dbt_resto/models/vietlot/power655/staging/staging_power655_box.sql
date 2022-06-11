

      create or replace transient table vietlot_power655.staging.staging_power655_box  as
      (select

          md5(cast(coalesce(cast(box_id as 
    varchar
), '') as 
    varchar
)) as sk_box

        ,cast(box_date as 
    date
) as box_date
        ,box_id
        ,box_name
        ,box_result_numbers

        ,cast(try_parse_json(box_result_numbers)[0] as 
    int
) as box_result_number_1
        ,cast(try_parse_json(box_result_numbers)[1] as 
    int
) as box_result_number_2
        ,cast(try_parse_json(box_result_numbers)[2] as 
    int
) as box_result_number_3
        ,cast(try_parse_json(box_result_numbers)[3] as 
    int
) as box_result_number_4
        ,cast(try_parse_json(box_result_numbers)[4] as 
    int
) as box_result_number_5
        ,cast(try_parse_json(box_result_numbers)[5] as 
    int
) as box_result_number_6
        ,cast(try_parse_json(box_result_numbers)[6] as 
    int
) as box_result_number_7

from    vietlot_power655.landing.power655_data
      );
    