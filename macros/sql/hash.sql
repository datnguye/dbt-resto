{% macro hash(fields) -%}

  {%- set field_concat %}

    concat('',
    {%- for item in fields %}
      coalesce(cast({{ item }} as {{ dbt_resto.type_string() }}), '') {% if not loop.last %},{% endif %}
    {%- endfor %})

  {%- endset %}
  {{ adapter.dispatch('hash', 'dbt_resto') (field_concat) }}

{%- endmacro %}


{% macro default__hash(field) -%}
    md5(cast({{field}} as {{dbt_resto.type_string()}}))
{%- endmacro %}

{% macro sqlserver__hash(field) -%}
    convert(varchar(32), hashbytes('MD5',  coalesce(cast({{field}} as varchar ), '')), 2)
{%- endmacro %}