{% macro get_time_dimension(level='hour') %}
  {{ adapter.dispatch('get_time_dimension', 'dbt_resto') (level) }}
{% endmacro %}

{% macro default__get_time_dimension(level) %}

with base_times as (
  {{ dbt_resto.get_base_times(level) }}
)

select    time_value,--string of HH:MM:SS

          null as hour_number,
          null as hour_name, --string of HH:00:00 AM/PM
          null as hour24_number,
          null as hour24_name, --string of HH:00:00

          {%- if level == 'minute' %}

          null as minute_number,
          null as minute_name, --string of HH:MM:00

          {%- endif %}

          {%- if level == 'second' %}

          null as second_number,

          {%- endif %}

          null as time_key --number of HHMMSS

from      base_times
order by  1

{% endmacro %}


{% macro sqlserver__get_time_dimension(level) %}
{#
with base_times as (
  {{ dbt_resto.get_base_times(level) }}
)

select    time_value
from      base_times

order by  1 #}

{% endmacro %}