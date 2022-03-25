{% macro get_base_times(level='hour', base='1970-01-01') %}
    {{ adapter.dispatch('get_base_times', 'dbt_resto') (level, base) }}
{% endmacro %}

{% macro default__get_base_times(level, base) %}

  {%- if level == 'second' %}
    {# 1 day = 86400 seconds #}
    with E1(N) as
    (
      select 1 union all select 1 union all select 1 union all
      select 1 union all select 1 union all select 1 union all
      select 1 union all select 1 union all select 1 union all select 1
    ) --10E+1 or 10 rows
    ,E2(N) as
    (
      select 1 from E1 a, E1 b
    ) --10E+2 or 100 rows
    ,E3(N) as
    (
      select 1 from E2 a, E2 b
    ) --10E+4 or 10,000 rows
    ,E4(N) as
    (
      select 1 FROM E3 a, E3 b
    ) --10E+8 or 100,000,000 rows
    ,EALL as (
      select  {% if target.type == 'sqlserver' %} top 86400 {% endif %}
              N,
              row_number() over (order by N) as value
      from    E4
      order by 2
      {% if target.type != 'sqlserver' %} limit 86400 {% endif %}
    )
    select  dateadd(second, value, '{{ base }}') as time_value
    from    EALL

  {%- elif level == 'minute' %}

    {# 1 day = 1440 minutes #}
    {%- for value in range(0, 1440) %}
      select dateadd(minute, {{ value }}, '{{ base }}') as time_value
      {%- if not loop.last %}
        union all
      {%- endif %}
    {%- endfor %}

  {%- else %}

    {# 1 day = 24 hours #}
    {%- for value in range(0, 24) %}
      select dateadd(hour, {{ value }}, '{{ base }}') as time_value
      {%- if not loop.last %}
        union all
      {%- endif %}
    {%- endfor %}

  {%- endif %}

{% endmacro %}