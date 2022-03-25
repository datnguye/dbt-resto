{% macro compile_money_to_words() %}
  {{ return(adapter.dispatch('compile_money_to_words', 'dbt_resto')()) }}
{% endmacro %}

{% macro default__compile_money_to_words() %}
  {%- if execute -%}
    {% set compile_sql -%}
      CREATE SCHEMA IF NOT EXISTS {{var('num2words_schema', 'dbtresto')}};
      {{ dbt_resto.compile_money_to_words_en() }};
      {#-- {{ dbt_resto.compile_money_to_words_vi() }} #}
    {% endset %}
    {% do run_query(compile_sql) %}

  {% endif %}
{% endmacro %}


{% macro sqlserver__compile_money_to_words() %}
  {%- if execute -%}
    {% set create_schema -%}
      IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = '{{ var("num2words_schema", "dbtresto") }}')
      BEGIN
        EXEC('CREATE SCHEMA [{{ var("num2words_schema", "dbtresto") }}]')
      END
    {% endset %}
    {{ log(create_schem, info=True) }}
    {% do run_query(create_schema) %}

    {% set compile_sql -%}
      {{ dbt_resto.compile_money_to_words_en() }};
      {#-- {{ dbt_resto.compile_money_to_words_vi() }} #}
    {% endset %}
    {% do run_query(compile_sql) %}

  {% endif %}
{% endmacro %}