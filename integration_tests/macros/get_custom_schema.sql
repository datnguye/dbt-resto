{#/*
	:MAKE-A-COPY:
  Copy this macro into your project/macros directory in case you'd like to override the default schema behaviour
*/#}

{% macro generate_schema_name(custom_schema_name, node) -%}

  {%- set default_schema = target.schema -%}
  {%- if custom_schema_name is none -%}

      {{ default_schema }}

  {%- else -%}

      {{ custom_schema_name | trim }}

  {%- endif -%}

{%- endmacro %}
