select  {%- if target.type == 'sqlserver' %}

          {{ dbt_resto.hash(['box_id']) }}

        {%- else %}

          {{ dbt_utils.surrogate_key(['box_id']) }}

        {%- endif %} as sk_box

        ,cast(box_date as {{ dbt_resto.type_date() }}) as box_date
        ,box_id
        ,box_name
        ,box_result_numbers

{%- if target.type == 'sqlserver' %}

        ,result_numbers.box_result_number_1
        ,result_numbers.box_result_number_2
        ,result_numbers.box_result_number_3
        ,result_numbers.box_result_number_4
        ,result_numbers.box_result_number_5
        ,result_numbers.box_result_number_6
        ,result_numbers.box_result_number_7

{%- else %}

        ,cast(try_parse_json(box_result_numbers)[0] as {{ dbt_resto.type_int() }}) as box_result_number_1
        ,cast(try_parse_json(box_result_numbers)[1] as {{ dbt_resto.type_int() }}) as box_result_number_2
        ,cast(try_parse_json(box_result_numbers)[2] as {{ dbt_resto.type_int() }}) as box_result_number_3
        ,cast(try_parse_json(box_result_numbers)[3] as {{ dbt_resto.type_int() }}) as box_result_number_4
        ,cast(try_parse_json(box_result_numbers)[4] as {{ dbt_resto.type_int() }}) as box_result_number_5
        ,cast(try_parse_json(box_result_numbers)[5] as {{ dbt_resto.type_int() }}) as box_result_number_6
        ,cast(try_parse_json(box_result_numbers)[6] as {{ dbt_resto.type_int() }}) as box_result_number_7

{%- endif %}

from    {{ ref('vietlot_power655_data') }}

{%- if target.type == 'sqlserver' %}
outer apply (
          select   cast([1] as {{ dbt_resto.type_int() }}) as box_result_number_1
                  ,cast([2] as {{ dbt_resto.type_int() }}) as box_result_number_2
                  ,cast([3] as {{ dbt_resto.type_int() }}) as box_result_number_3
                  ,cast([4] as {{ dbt_resto.type_int() }}) as box_result_number_4
                  ,cast([5] as {{ dbt_resto.type_int() }}) as box_result_number_5
                  ,cast([6] as {{ dbt_resto.type_int() }}) as box_result_number_6
                  ,cast([7] as {{ dbt_resto.type_int() }}) as box_result_number_7
          from    (
                    select  value,
                            row_number() over (order by getdate()) as rn
                    from    string_split(replace(replace(replace(box_result_numbers, ' ',''),'[',''),']',''), ',')
                  ) as r
                  pivot
                  (
                    max(value)
                    for rn in ([1],[2],[3],[4],[5],[6],[7])
                  ) as p
) as result_numbers
{%- endif %}