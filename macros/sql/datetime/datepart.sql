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

{% macro postgres__datepart(column, part) %}

  {%- set mapped_part = part -%}
  {%- if part == 'dayofweek' -%}
    {%- set mapped_part = 'dow' -%}
  {%- endif -%}
  {%- if part == 'dayofyear' -%}
    {%- set mapped_part = 'doy' -%}
  {%- endif -%}
  date_part('{{ mapped_part }}', {{ column }})

{% endmacro %}