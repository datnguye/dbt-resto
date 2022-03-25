{% macro money_to_words(column, lang='en') %}
  {{ return(adapter.dispatch('money_to_words', 'dbt_resto')(column, lang)) }}
{% endmacro %}

{% macro default__money_to_words(column, lang='en') %}
  {{var('num2words_schema', 'dbtresto')}}.MoneyToWords_{{lang|upper}}(floor({{column}}), {{column}} - floor({{column}}))
{% endmacro %}

{% macro sqlserver__money_to_words(column, lang='en') %}
  {{var('num2words_schema', 'dbtresto')}}.MoneyToWords_{{lang|upper}}({{column}})
{% endmacro %}