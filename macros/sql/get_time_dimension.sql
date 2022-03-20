{% macro get_time_dimension(level='hour') %}
  {{ adapter.dispatch('get_time_dimension', 'dbt_resto') (level) }}
{% endmacro %}

{% macro default__get_time_dimension(level) %}

with base_times as (
  {{ dbt_resto.get_base_times(level) }}
)

select    time_value,

          null as hour_number,
          null as hour_name, --string of HH:00:00
          null as prior_time_hour_number,
          null as prior_time_hour_name,
          null as next_time_hour_number,
          null as next_time_hour_name,

          {%- if level == 'minute' %}

          null as minute_number,
          null as minute_name, --string of MM:00
          null as prior_time_minute_number,
          null as prior_time_minute_name,
          null as next_time_minute_number,
          null as next_time_minute_name,

          {%- endif %}

          null as time_key --string of HHMMSS

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