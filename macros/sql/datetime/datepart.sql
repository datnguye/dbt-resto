{% macro datepart(column, part='day') %}
    {{ adapter.dispatch('datepart', 'dbt_resto') (column, part) }}
{% endmacro %}

{% macro default__datepart(column, part) %}

  date_part({{ part }}, {{ column }})

{% endmacro %}

{% macro sqlserver__datepart(column, part) %}

  datepart({{ part }}, {{ column }})

{% endmacro %}