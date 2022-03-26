{% macro get_time_key(column, parts=['hour','minute','second'], h24=True) %}
  {{ adapter.dispatch('get_time_key', 'dbt_resto') (column, parts, h24) }}
{% endmacro %}

{% macro default__get_time_key(column, parts, h24) %}

  {%- set pattern -%}
    {%- if 'hour' in parts -%} HH {%- if h24 -%} 24 {%- else -%} 12 {%- endif -%} {%- else -%} 00 {%- endif -%}
    {%- if 'minute' in parts -%} MI {%- else -%} 00 {%- endif -%}
    {%- if 'second' in parts -%} SS {%- else -%} 00 {%- endif -%}
  {%- endset -%}
  to_varchar({{ column }}, '{{ pattern }}')

{% endmacro %}

{% macro sqlserver__get_time_key(column, parts, h24) %}

  {%- set pattern -%}
    {%- if 'hour' in parts -%} {%- if h24 -%} HH {%- else -%} hh {%- endif -%} {%- else -%} 00 {%- endif -%}
    {%- if 'minute' in parts -%} mm {%- else -%} 00 {%- endif -%}
    {%- if 'second' in parts -%} ss {%- else -%} 00 {%- endif -%}
  {%- endset -%}
  format({{ column }}, '{{ pattern }}')

{% endmacro %}