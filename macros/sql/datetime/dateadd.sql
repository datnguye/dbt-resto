{% macro dateadd(datepart, interval, column) %}
  {{ return(adapter.dispatch('dateadd', 'dbt_resto')(datepart, interval, column)) }}
{% endmacro %}


{% macro default__dateadd(datepart, interval, column) -%}

  dateadd({{ datepart }}, {{ interval }}, {{ column }})

{%- endmacro %}

{% macro postgres__dateadd(datepart, interval, column) -%}

  cast({{ column }} as {{ dbt_resto.type_date() }}) + {{ interval }} * interval '1 {{ datepart }}'

{%- endmacro %}