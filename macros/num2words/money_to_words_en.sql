{% macro money_to_words_en(column) %}
  {{ return(adapter.dispatch('money_to_words_en', 'dbt_resto')(column)) }}
{% endmacro %}

{% macro compile_money_to_words_en() %}
  {{ return(adapter.dispatch('compile_money_to_words_en', 'dbt_resto')()) }}
{% endmacro %}

{% macro default__money_to_words_en(column) %}
  {{var('num2words_schema', 'dbtresto')}}.MoneyToWords_EN({{column}})

{% endmacro %}