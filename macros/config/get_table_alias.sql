{#/*
	Suffix the table name with your configured variable `table_suffix`
  Usage:
    {{ config(alias=dbt_resto.get_table_alias(this)) }}
*/#}

{% macro get_table_alias(relation) %}
  {{ adapter.dispatch('get_table_alias', 'dbt_resto') (relation) }}
{% endmacro %}

{% macro default__get_table_alias(relation) -%}

  {{ relation.table ~ var('table_suffix','') }}

{%- endmacro %}