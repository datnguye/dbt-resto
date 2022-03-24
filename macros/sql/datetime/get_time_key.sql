{% macro get_time_key(column, parts=['hour','minute','second'], h24=True) %}
  {{ adapter.dispatch('get_time_key', 'dbt_resto') (column, parts, h24) }}
{% endmacro %}

{% macro default__get_time_key(column, parts, h24) %}

  {%- set pattern -%}
    {%- for part in parts -%}
      {%- if part = 'hour' -%} 'HH' ~ ({%- if h24 -%} '24' {%- else -%} '' {%- endif -%}) {%- else -%} '00' {%- endif -%}
    ~ {%- if part = 'hour' -%} 'MI' {%- else -%} '00' {%- endif -%}
    ~ {%- if part = 'hour' -%} 'SS' {%- else -%} '00' {%- endif -%}
    {%- endfor -%}
  {%- endset -%}
  to_varchar({{ column }}, '{{ pattern }}')

{% endmacro %}

{% macro sqlserver__get_time_key(column, parts, h24) %}

  {%- set pattern -%}
    {%- for part in parts -%}
      {%- if part = 'hour' -%} ({%- if h24 -%} 'HH' {%- else -%} 'hh' {%- endif -%}) {%- else -%} '00' {%- endif -%}
    ~ {%- if part = 'hour' -%} 'mm' {%- else -%} '00' {%- endif -%}
    ~ {%- if part = 'hour' -%} 'ss' {%- else -%} '00' {%- endif -%}
    {%- endfor -%}
  {%- endset -%}
  format({{ column }}, '{{ pattern }}')

{% endmacro %}