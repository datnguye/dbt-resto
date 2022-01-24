{#
  -- Convert str to date with date format
#}

{% macro str_to_date(column_name, pattern='yyyymmdd') %}
  {{ return(adapter.dispatch('str_to_date')(column_name, pattern)) }}
{% endmacro %}

{% macro default__str_to_date(column_name, pattern) -%}
  
  to_date({{column_name}}::varchar, '{{pattern|upper}}')

{%- endmacro %}
