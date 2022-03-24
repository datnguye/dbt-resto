{# string  -------------------------------------------------     #}

{%- macro type_string() -%}
  {{ return(adapter.dispatch('type_string', 'dbt_resto')()) }}
{%- endmacro -%}

{% macro default__type_string() %}
    varchar
{% endmacro %}

{%- macro sqlserver__type_string() -%}
    nvarchar
{%- endmacro -%}


{# timestamp  -------------------------------------------------     #}

{%- macro type_timestamp() -%}
  {{ return(adapter.dispatch('type_timestamp', 'dbt_resto')()) }}
{%- endmacro -%}

{% macro default__type_timestamp() %}
    timestamp
{% endmacro %}

{% macro sqlserver__type_timestamp() %}
    datetime
{% endmacro %}


{# float  -------------------------------------------------     #}

{%- macro type_float() -%}
  {{ return(adapter.dispatch('type_float', 'dbt_resto')()) }}
{%- endmacro -%}

{% macro default__type_float() %}
    float
{% endmacro %}

{# numeric  ------------------------------------------------     #}

{%- macro type_numeric() -%}
  {{ return(adapter.dispatch('type_numeric', 'dbt_resto')()) }}
{%- endmacro -%}

{% macro default__type_numeric() %}
    numeric(28, 6)
{% endmacro %}


{# bigint  -------------------------------------------------     #}

{%- macro type_bigint() -%}
  {{ return(adapter.dispatch('type_bigint', 'dbt_resto')()) }}
{%- endmacro -%}

{% macro default__type_bigint() %}
    bigint
{% endmacro %}

{# int  -------------------------------------------------     #}

{%- macro type_int() -%}
  {{ return(adapter.dispatch('type_int', 'dbt_resto')()) }}
{%- endmacro -%}

{% macro default__type_int() %}
    int
{% endmacro %}