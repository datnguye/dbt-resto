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


{% macro sqlserver__if_column_value_to_match_regex(model, column_name, regex_expr) %}

  select 'NOT SUPPORTED!' where 1 = 0

{% endmacro %}


{% macro postgres__if_column_value_to_match_regex(model, column_name, regex_expr) %}

  {% set expression -%}
    (select array_agg(i) from (select (regexp_matches({{ column_name }}, '{{ regex_expr }}', 'g'))[1] i) as t)::varchar
  {%- endset %}

  with exceptions as (
    select  {{ column_name }},
            {{ expression }} as {{ column_name }}_matched

    from    {{ model }}
  )
  select  *
  from    exceptions
  where   {{ column_name }} is not null
    and   (
                {{ column_name }}_matched is null
            or  length({{ column_name }}_matched) = 0
          )

{% endmacro %}
