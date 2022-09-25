{{
  config(
    materialized = 'incremental',
    unique_key = 'forecast_date',
  )
}}

{%- set run_date = env_var("DBT_ENV_RUN_DATE", "current_timestamp") -%}

with forecast as (

  select * from {{ ref('fact_number_scoring') }}

  where   1 = 1
    and   forecast_date = cast({{ run_date }} as {{ dbt_resto.type_date() }})

),

dim_box as (

  select * from {{ ref('dim_box') }}

),

selecting_1 as ( select top 1 number_value, forecast_date from forecast order by rank_pos_1 desc),
selecting_2 as ( select top 1 number_value, forecast_date from forecast where number_value not in (select number_value from selecting_1) order by rank_pos_2 desc),
selecting_3 as ( select top 1 number_value, forecast_date from forecast where number_value not in (select number_value from selecting_1 {% for i in [2]     %}union all select number_value from selecting_{{ i }} {% endfor %}) order by rank_pos_3 desc),
selecting_4 as ( select top 1 number_value, forecast_date from forecast where number_value not in (select number_value from selecting_1 {% for i in [2,3]   %}union all select number_value from selecting_{{ i }} {% endfor %}) order by rank_pos_4 desc),
selecting_5 as ( select top 1 number_value, forecast_date from forecast where number_value not in (select number_value from selecting_1 {% for i in [2,3,4] %}union all select number_value from selecting_{{ i }} {% endfor %}) order by rank_pos_5 desc),
selecting_6 as ( select top 1 number_value, forecast_date from forecast where number_value not in (select number_value from selecting_1 {% for i in [2,3,5] %}union all select number_value from selecting_{{ i }} {% endfor %}) order by rank_pos_6 desc),

selecting as (

  (select top 1 number_value, forecast_date from selecting_1) union all
  (select top 1 number_value, forecast_date from selecting_2) union all
  (select top 1 number_value, forecast_date from selecting_3) union all
  (select top 1 number_value, forecast_date from selecting_4) union all
  (select top 1 number_value, forecast_date from selecting_5) union all
  (select top 1 number_value, forecast_date from selecting_6)

),

selecting_order as (

  select number_value, forecast_date, row_number() over(order by number_value) as rn from selecting

),

forecasting as (

  select  forecast_date
          ,concat(max(case when rn = 1 then number_value else null end)
            ,',', max(case when rn = 2 then number_value else null end)
            ,',', max(case when rn = 3 then number_value else null end)
            ,',', max(case when rn = 4 then number_value else null end)
            ,',', max(case when rn = 5 then number_value else null end)
            ,',', max(case when rn = 6 then number_value else null end)
          ) as forecast_numbers
          ,max(case when rn = 1 then number_value else null end) as forecast_1
          ,max(case when rn = 2 then number_value else null end) as forecast_2
          ,max(case when rn = 3 then number_value else null end) as forecast_3
          ,max(case when rn = 4 then number_value else null end) as forecast_4
          ,max(case when rn = 5 then number_value else null end) as forecast_5
          ,max(case when rn = 6 then number_value else null end) as forecast_6

  from    selecting_order

  group by forecast_date

),

final as (

  select      top 1 forecasting.forecast_date, dim_box.box_date as last_box_date
              ,forecast_numbers,box_result_numbers as last_box_result_numbers
              ,forecast_1, box_result_number_1 as last_box_result_number_1
              ,forecast_2, box_result_number_2 as last_box_result_number_2
              ,forecast_3, box_result_number_3 as last_box_result_number_3
              ,forecast_4, box_result_number_4 as last_box_result_number_4
              ,forecast_5, box_result_number_5 as last_box_result_number_5
              ,forecast_6, box_result_number_6 as last_box_result_number_6

  from        forecasting
  left join   dim_box
    on        dim_box.box_date < forecasting.forecast_date

  order by    dim_box.box_date desc
)

select   *

from    final