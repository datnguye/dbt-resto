{#
	--Suffix the table name with your configured variable `table_suffix`
#}

{% macro get_table_alias(relation) -%}
    
    {{ relation.table ~ var('table_suffix','') }}

{%- endmacro %}
