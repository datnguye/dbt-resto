{% macro datepart(column, part='day') %}
    {{ adapter.dispatch('datepart', 'dbt_resto') (column, part) }}
{% endmacro %}

{% macro default__datepart(column, part) %}

  date_part({{ part }}, {{ column }})

{% endmacro %}

{% macro sqlserver__datepart(column, part) %}

  {%- set mapped_part = part -%}
  {%- if part == 'dayofweek' -%}
    {%- set mapped_part = 'weekday' -%}
  {%- endif -%}
  {%- if part == 'week' -%}
    {%- set mapped_part = 'iso_week' -%}
  {%- endif -%}
  datepart({{ mapped_part }}, {{ column }})

{% endmacro %}