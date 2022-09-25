{{
  config(
    materialized = 'incremental',
    unique_key = 'fact_key',
  )
}}

{%- set run_date = env_var("DBT_ENV_RUN_DATE") or "current_timestamp" -%}

with total_box as (

  select count(1) as no from {{ ref('dim_box') }} where box_date < {{ run_date }}

),

weighting as (

  select   number_value
          ,(total_box.no - occurrence.occurrence      ) + (datediff(day, occurrence.last_appearance      , {{ run_date }})) as weight
          ,(total_box.no - occurrence.occurrence_pos_1) + (datediff(day, occurrence.last_appearance_pos_1, {{ run_date }})) as weight_1
          ,(total_box.no - occurrence.occurrence_pos_2) + (datediff(day, occurrence.last_appearance_pos_2, {{ run_date }})) as weight_2
          ,(total_box.no - occurrence.occurrence_pos_3) + (datediff(day, occurrence.last_appearance_pos_3, {{ run_date }})) as weight_3
          ,(total_box.no - occurrence.occurrence_pos_4) + (datediff(day, occurrence.last_appearance_pos_4, {{ run_date }})) as weight_4
          ,(total_box.no - occurrence.occurrence_pos_5) + (datediff(day, occurrence.last_appearance_pos_5, {{ run_date }})) as weight_5
          ,(total_box.no - occurrence.occurrence_pos_6) + (datediff(day, occurrence.last_appearance_pos_6, {{ run_date }})) as weight_6

  from    {{ ref('fact_number') }} as occurrence
  join    total_box on 1 = 1

),

scoring as (

  select   number_value
          ,weight + weight_1 as score_1
          ,weight + weight_2 as score_2
          ,weight + weight_3 as score_3
          ,weight + weight_4 as score_4
          ,weight + weight_5 as score_5
          ,weight + weight_6 as score_6

  from    weighting

),

final as (

  select   number_value
          ,score_1
          ,score_2
          ,score_3
          ,score_4
          ,score_5
          ,score_6
          ,{{ dbt_resto.random() }} * coalesce(score_1,0) as rank_pos_1
          ,{{ dbt_resto.random() }} * coalesce(score_2,0) as rank_pos_2
          ,{{ dbt_resto.random() }} * coalesce(score_3,0) as rank_pos_3
          ,{{ dbt_resto.random() }} * coalesce(score_4,0) as rank_pos_4
          ,{{ dbt_resto.random() }} * coalesce(score_5,0) as rank_pos_5
          ,{{ dbt_resto.random() }} * coalesce(score_6,0) as rank_pos_6

  from    scoring

)

select   concat(cast({{ run_date }} as {{ dbt_resto.type_date() }}),'-',number_value) as fact_key
        ,cast({{ run_date }} as {{ dbt_resto.type_date() }}) as forecast_date
        ,*

from    final