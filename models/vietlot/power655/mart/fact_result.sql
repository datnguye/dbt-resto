{{
  config(
    materialized = 'incremental',
    unique_key = 'fact_result_key',
  )
}}

select  {% if target.type == 'sqlserver' %} {{ dbt_resto.hash(['b.sk_box','bd.prize_name','b.box_date']) }}
        {% else %} {{ dbt_utils.surrogate_key(['b.sk_box','bd.prize_name','b.box_date']) }}
        {% endif %} as fact_result_key

        ,b.sk_box as box_key

        ,{% if target.type == 'sqlserver' %} {{ dbt_resto.hash(['bd.prize_name']) }}
        {% else %} {{ dbt_utils.surrogate_key(['bd.prize_name']) }}
        {% endif %} as prize_key

        ,b.box_date as date_key
        ,bd.prize_won as no_of_won
        ,bd.prize_value as prize_value
        ,bd.prize_value * bd.prize_won as prize_paid
        ,case
          when bd.prize_won > 0 then 1
          else 0
        end as is_prize_taken

from    {{ ref('staging_power655_box') }} as b
join    {{ ref('staging_power655_box_detail') }} as bd
  on    bd.box_id = b.box_id

where   1 = 1

{% if is_incremental() %}

  and   b.box_date > coalesce((select max(date_key) from {{ this }}), '1900-01-01')

{% endif %}