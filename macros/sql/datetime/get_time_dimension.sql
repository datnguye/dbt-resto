{% macro get_time_dimension(level='hour') %}
  {{ adapter.dispatch('get_time_dimension', 'dbt_resto') (level, kwargs) }}
{% endmacro %}

{% macro default__get_time_dimension(level, kwargs) %}

with base_times as (
{%- if target.type in ['sqlserver'] and level == 'second' %}

  {%- set base_table = kwargs.get('base_table') -%}
  {#-- get_base_times producs WITH statement but SQL Server wont accept WITH inside WITH #}
  select  dateadd(second, value, '{{ base }}') as time_value
  from    {{ base_table }}

{%- else %}

  {{ dbt_resto.get_base_times(level) }}

{%- endif %}
)

select    time_value,--string of HH:MM:SS
          concat(
            {{ dbt_resto.get_time_key('time_value', ['hour','minute','second'], False) }},
            ' ',
            case
              when cast({{ dbt_resto.datepart('time_value', 'hour') }} as {{ dbt_resto.type_int() }}) between 12 and 23
                then  'PM'
              else    'AM'
            end
          ) as time_string, --string of HH:MM:SS AM/PM
          {{ dbt_resto.get_time_key('time_value', ['hour','minute','second']) }} as time24_string,--string of HH:MM:SS

          case
            when cast({{ dbt_resto.datepart('time_value', 'hour') }} as {{ dbt_resto.type_int() }}) > 12
              then  cast({{ dbt_resto.datepart('time_value', 'hour') }} as {{ dbt_resto.type_int() }}) - 12
            else    cast({{ dbt_resto.datepart('time_value', 'hour') }} as {{ dbt_resto.type_int() }})
          end as hour_number,
          concat(
            {{ dbt_resto.get_time_key('time_value', ['hour'], False) }},
            ' ',
            case
              when cast({{ dbt_resto.datepart('time_value', 'hour') }} as {{ dbt_resto.type_int() }}) between 12 and 23
                then  'PM'
              else    'AM'
            end
          ) as hour_name, --string of HH:00:00 AM/PM
          cast({{ dbt_resto.datepart('time_value', 'hour') }} as {{ dbt_resto.type_int() }}) as hour24_number,
          {{ dbt_resto.get_time_key('time_value', ['hour']) }} as hour24_name, --string of HH:00:00

          {%- if level in ['minute', 'second'] %}

          cast({{ dbt_resto.datepart('time_value', 'minute') }} as {{ dbt_resto.type_int() }}) as minute_number,
          concat(
            {{ dbt_resto.get_time_key('time_value', ['hour','minute'], False) }},
            ' ',
            case
              when cast({{ dbt_resto.datepart('time_value', 'hour') }} as {{ dbt_resto.type_int() }}) between 12 and 23
                then  'PM'
              else    'AM'
            end
          ) as hour_minute_name, --string of HH:MM:00 AM/PM
          {{ dbt_resto.get_time_key('time_value', ['hour','minute']) }} as hour24_minute_name, --string of HH:MM:00

          {%- endif %}

          {%- if level in ['second'] %}

          cast({{ dbt_resto.datepart('time_value', 'second') }} as {{ dbt_resto.type_int() }}) as second_number,

          {%- endif %}

          cast({{ dbt_resto.get_time_key('time_value') }} as {{ dbt_resto.type_bigint() }}) as time_key --number of HHMMSS

from      base_times

{% endmacro %}