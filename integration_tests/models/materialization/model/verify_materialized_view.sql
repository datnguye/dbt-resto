{% if target.type in ['sqlserver'] %}

{{
  config(
    materialized = 'materialized_view',
    unique_key = 'time_key',
  )
}}

select  time_key,
        time_value
from    {{ ref('verify_get_time_dimension_second').include(database=False) }}

{% else %}

{# Currently disable this model as we're using Standard Edition in CI #}
{{
  config(
    materialized = 'materialized_view',
    enabled = (target.type != 'snowflake')
  )
}}

select  time_key,
        time_value
from    {{ ref('verify_get_time_dimension_second') }}

{% endif %}