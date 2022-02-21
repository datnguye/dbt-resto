{% macro compile_money_to_words_en() %}
  {{ return(adapter.dispatch('compile_money_to_words_en', 'dbt_resto')()) }}
{% endmacro %}

{% macro default__compile_money_to_words_en() %}


{% endmacro %}