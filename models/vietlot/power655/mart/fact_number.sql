{%- set numbers = [
     1, 2, 3, 4, 5, 6, 7, 8, 9,10,
    11,12,13,14,15,16,17,18,19,20,
    21,22,23,24,25,26,27,28,29,30,
    31,32,33,34,35,36,37,38,39,40,
    41,42,43,44,45,46,47,48,49,50,
    51,52,53,54,55
] -%}

with numbers as (

{%- for item in numbers %}
  select {{ item }} as number_value {% if not loop.last %} union all{% endif %}
{%- endfor %}

),

staging_box as (
  select * from {{ ref('staging_power655_box') }}
)

select       numbers.number_value

            ,sum(case when staging_box.box_id is null then 0 else 1 end) as occurrence
            ,sum(case when staging_box.box_result_number_1 = numbers.number_value then 1 else 0 end) as occurrence_pos_1
            ,sum(case when staging_box.box_result_number_2 = numbers.number_value then 1 else 0 end) as occurrence_pos_2
            ,sum(case when staging_box.box_result_number_3 = numbers.number_value then 1 else 0 end) as occurrence_pos_3
            ,sum(case when staging_box.box_result_number_4 = numbers.number_value then 1 else 0 end) as occurrence_pos_4
            ,sum(case when staging_box.box_result_number_5 = numbers.number_value then 1 else 0 end) as occurrence_pos_5
            ,sum(case when staging_box.box_result_number_6 = numbers.number_value then 1 else 0 end) as occurrence_pos_6
            ,sum(case when staging_box.box_result_number_7 = numbers.number_value then 1 else 0 end) as occurrence_pos_7

            ,max(staging_box.box_date) as last_appearance
            ,max(case when staging_box.box_result_number_1 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_1
            ,max(case when staging_box.box_result_number_2 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_2
            ,max(case when staging_box.box_result_number_3 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_3
            ,max(case when staging_box.box_result_number_4 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_4
            ,max(case when staging_box.box_result_number_5 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_5
            ,max(case when staging_box.box_result_number_6 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_6
            ,max(case when staging_box.box_result_number_7 = numbers.number_value then staging_box.box_date else null end) as last_appearance_pos_7

from        numbers
left join   staging_box
  on        staging_box.box_result_number_1 = numbers.number_value
  or        staging_box.box_result_number_2 = numbers.number_value
  or        staging_box.box_result_number_3 = numbers.number_value
  or        staging_box.box_result_number_4 = numbers.number_value
  or        staging_box.box_result_number_5 = numbers.number_value
  or        staging_box.box_result_number_6 = numbers.number_value
  or        staging_box.box_result_number_7 = numbers.number_value

group by    numbers.number_value