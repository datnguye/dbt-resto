select  {{ dbt_utils.surrogate_key(['box_id']) }} as sk_box
        ,cast(box_date as {{ dbt_resto.type_date() }}) as box_date
        ,box_id
        ,box_name
        ,box_result_numbers
        ,cast(try_parse_json(box_result_numbers)[0] as {{ dbt_utils.type_int() }}) as box_result_number_1
        ,cast(try_parse_json(box_result_numbers)[1] as {{ dbt_utils.type_int() }}) as box_result_number_2
        ,cast(try_parse_json(box_result_numbers)[2] as {{ dbt_utils.type_int() }}) as box_result_number_3
        ,cast(try_parse_json(box_result_numbers)[3] as {{ dbt_utils.type_int() }}) as box_result_number_4
        ,cast(try_parse_json(box_result_numbers)[4] as {{ dbt_utils.type_int() }}) as box_result_number_5
        ,cast(try_parse_json(box_result_numbers)[5] as {{ dbt_utils.type_int() }}) as box_result_number_6
        ,cast(try_parse_json(box_result_numbers)[6] as {{ dbt_utils.type_int() }}) as box_result_number_7

from    {{ ref('vietlot_power655_data') }}