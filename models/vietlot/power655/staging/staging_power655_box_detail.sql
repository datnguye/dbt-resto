{% if target.type == 'snowflake' %}

select  {{ dbt_utils.surrogate_key(['box_id', 'value:prize_name']) }} as sk_box_detail
        ,box_id
        ,cast(value:prize_name as {{ dbt_resto.type_string() }}) as prize_name
        ,cast(value:prize_won as {{ dbt_resto.type_int() }}) as prize_won
        ,cast(value:prize_value_raw as {{ dbt_resto.type_string() }}) as prize_value_raw
        ,cast(value:prize_value as {{ dbt_resto.type_float() }}) as prize_value

from    {{ ref('vietlot_power655_data') }}
        ,lateral flatten(input => try_parse_json(box_results))

where   prize_name is not null

{% else %}

select  {{ dbt_resto.hash(['box_id', 'box_results.prize_name']) }} as sk_box_detail
        ,box_id
        ,box_results.*

from    {{ ref('vietlot_power655_data') }}
outer apply (
  select  prizes.*
  from    openjson(box_results) with (box_result nvarchar(max) '$' as json)
  outer apply openjson(box_result)
  with    (
            prize_name nvarchar(10) '$.prize_name',
            prize_won int '$.prize_won',
            prize_value_raw nvarchar(100) '$.prize_value_raw',
            prize_value float '$.prize_value'
          ) as prizes
) as box_results

where   box_results.prize_name is not null

{% endif %}