{% macro len(column) %}
  {{ return(adapter.dispatch('len', 'dbt_resto')(column)) }}
{% endmacro %}


{% macro default__len(column) -%}

  len({{ column }})

{%- endmacro %}

{% macro postgres__len(column) -%}

  length({{ column }})

{%- endmacro %}