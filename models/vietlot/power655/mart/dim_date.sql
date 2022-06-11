{{
  config(
    materialized = 'incremental',
    unique_key = 'box_date',
  )
}}

select     box_date as date_key
          ,box_date
          ,{{ dbt_resto.datepart('box_date', 'day') }} as box_day
          ,{{ dbt_resto.datepart('box_date', 'week') }} as box_week
          ,{{ dbt_resto.datepart('box_date', 'month') }} as box_month
          ,substring(
            'Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec ',
            ({{ dbt_resto.datepart('box_date', 'month') }} * 4) - 3, 3) as box_month_name
          ,{{ dbt_resto.datepart('box_date', 'year') }} as box_year

from      {{ ref('staging_power655_box') }}

where     1 = 1
{% if is_incremental() %}

  and     box_date > coalesce((select max(box_date) from {{ this }}), '1900-01-01')

{% endif %}