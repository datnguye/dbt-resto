{#/*
	Test if a column value matching to a given regular expression
  NOTE: Snowflake support only
  Usage:
    models:
      - name: table_name
        columns:
          - name: column_name
            tests:
              - assert_column_values_to_match_regex:
                  regex_expr: '[a-zA-Z]' # matching text only
*/#}

{% test assert_column_values_to_match_regex(model, column_name, regex_expr) %}
  {{ return(adapter.dispatch('test_column_values_to_match_regex', 'dbt_resto')(model, column_name, regex_expr)) }}
{% endtest %}

{% macro default__test_column_values_to_match_regex(model, column_name, regex_expr) %}
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
