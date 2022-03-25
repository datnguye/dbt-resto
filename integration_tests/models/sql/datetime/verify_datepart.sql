{% if target.name == 'sqlserver' %}
{{
  config(
    pre_hook='set datefirst 1',
    materialized='table'
  )
}}
{% endif %}

with data as (
  select cast('2022-03-25 14:55:45' as {{ dbt_resto.type_timestamp() }}) as input
)
select input, 'year' as date_part,          {{ dbt_resto.datepart('input', 'year') }} as actual,          2022 as expected from data union all
select input, 'month' as date_part,         {{ dbt_resto.datepart('input', 'month') }} as actual,         3 as expected from data union all
select input, 'day' as date_part,           {{ dbt_resto.datepart('input', 'day') }} as actual,           25 as expected from data union all
select input, 'dayofweek' as date_part,     {{ dbt_resto.datepart('input', 'dayofweek') }} as actual,     5 as expected from data union all
select input, 'dayofyear' as date_part,     {{ dbt_resto.datepart('input', 'dayofyear') }} as actual,     84 as expected from data union all
select input, 'week' as date_part,          {{ dbt_resto.datepart('input', 'week') }} as actual,          12 as expected from data union all
select input, 'quarter' as date_part,       {{ dbt_resto.datepart('input', 'quarter') }} as actual,       1 as expected from data union all

select input, 'hour' as date_part,          {{ dbt_resto.datepart('input', 'hour') }} as actual,          14 as expected from data union all
select input, 'minute' as date_part,        {{ dbt_resto.datepart('input', 'minute') }} as actual,        55 as expected from data union all
select input, 'second' as date_part,        {{ dbt_resto.datepart('input', 'second') }} as actual,        45 as expected from data