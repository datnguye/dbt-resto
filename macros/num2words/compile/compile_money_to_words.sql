{% macro compile_money_to_words() %}
  {{ return(adapter.dispatch('compile_money_to_words', 'dbt_resto')()) }}
{% endmacro %}

{% macro default__compile_money_to_words() %}
  {%- if execute -%}
    {% set compile_sql -%}
      CREATE SCHEMA IF NOT EXISTS {{var('num2words_schema', 'dbtresto')}};
      {{compile_money_to_words_en()}}
      {#-- {{compile_money_to_words_vi()}} #}
    {% endset %}

    {% do run_query(compile_sql) %}
    
  {% endif %}
{% endmacro %}