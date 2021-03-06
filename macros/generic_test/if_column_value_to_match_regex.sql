{% test if_column_value_to_match_regex(model, column_name, regex_expr) %}
  {{ return(adapter.dispatch('if_column_value_to_match_regex', 'dbt_resto')(model, column_name, regex_expr)) }}
{% endtest %}

{% macro default__if_column_value_to_match_regex(model, column_name, regex_expr) %}

  {% set expression -%}
    regexp_instr({{ column_name }}, '{{ regex_expr }}') > 0
  {%- endset %}

  with exceptions as (
    select  {{column_name}}
    from    {{model}}
    where   not({{expression}})
  )
  select * from exceptions

{% endmacro %}
