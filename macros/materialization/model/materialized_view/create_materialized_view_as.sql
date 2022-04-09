{% macro create_materialized_view_as(relation, sql) -%}
  {{ adapter.dispatch('create_materialized_view_as', 'dbt_resto')(relation, sql) }}
{%- endmacro %}

{% macro default__create_materialized_view_as(relation, sql) -%}
  {%- set sql_header = config.get('sql_header', none) -%}

  {{ sql_header if sql_header is not none }}
  create materialized view {{ relation }} as (
    {{ sql }}
  );
{%- endmacro %}

{% macro sqlserver__create_materialized_view_as(relation, sql) -%}
  {%- set sql_header = config.get('sql_header', none) -%}
  {%- set temp_view_sql -%}
    create view {{ relation.include(database=False) }} with schemabinding as (
      {{ sql }}
    );
  {%- endset -%}

  {%- set temp_view_sql = temp_view_sql.replace("'", "''") -%}
  use [{{ relation.database }}];
  {{ sql_header if sql_header is not none }}
  execute('{{ temp_view_sql }}');
{%- endmacro %}