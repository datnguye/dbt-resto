{% if target.type == 'snowflake' %}

select  {{ dbt_utils.surrogate_key(['box_id', 'value:prize_name']) }} as sk_box_detail
        ,box_id
        ,cast(value:prize_name as {{ dbt_utils.type_string() }}) as prize_name
        ,cast(value:prize_won as {{ dbt_utils.type_int() }}) as prize_won
        ,cast(value:prize_value_raw as {{ dbt_utils.type_string() }}) as prize_value_raw
        ,cast(value:prize_value as {{ dbt_utils.type_float() }}) as prize_value

from    {{ ref('vietlot_power655_data') }}
        ,lateral flatten(input => try_parse_json(box_results))

{% else %}

select   box_id

from    {{ ref('vietlot_power655_data') }}

{% endif %}