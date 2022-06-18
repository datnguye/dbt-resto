select   sk_box as box_key
        ,box_id
        ,box_date
        ,box_result_numbers
        ,box_result_number_1
        ,box_result_number_2
        ,box_result_number_3
        ,box_result_number_4
        ,box_result_number_5
        ,box_result_number_6
        ,box_result_number_7

from    {{ ref('staging_power655_box') }}