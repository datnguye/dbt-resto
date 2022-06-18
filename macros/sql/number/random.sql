{% macro random() %}
    {{ adapter.dispatch('random', 'dbt_resto') () }}
{% endmacro %}

{% macro default__random() %}

  abs(random()) / pow(10,19)

{% endmacro %}

{% macro sqlserver__random() %}

  rand(cast(newid() as varbinary))

{% endmacro %}