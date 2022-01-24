{#
	-- Move this macro into your project/macros directory in case you'd like to override the default schema behaviour
#}

{% macro generate_schema_name(custom_schema_name, node) -%}

  {{ custom_schema_name | trim }}

{%- endmacro %}
