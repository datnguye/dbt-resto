{{
  config(
    materialized = 'incremental',
    unique_key = 'forecast_date',
  )
}}

with forecast as (

  select * from {{ ref('fact_forecast') }}

  where   1 = 1

  {% if is_incremental() %}

    and   forecast_date >= coalesce((select max(forecast_date) from {{ this }}), '1900-01-01')

  {% endif %}

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

  select      forecasting.forecast_date
              ,forecast_numbers,box_result_numbers
              ,forecast_1, box_result_number_1
              ,forecast_2, box_result_number_2
              ,forecast_3, box_result_number_3
              ,forecast_4, box_result_number_4
              ,forecast_5, box_result_number_5
              ,forecast_6, box_result_number_6

  from        forecasting
  left join   dim_box
    on        dim_box.box_date = forecasting.forecast_date

)

select   *

from    final