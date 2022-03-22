{% macro get_base_times(level='hour', base='1970-01-01') %}
    {{ adapter.dispatch('get_base_times', 'dbt_resto') (level, base) }}
{% endmacro %}

{% macro default__get_base_times(level, base) %}

  {%- if level == 'second' %}

    {# 1 day = 86400 seconds #}
    {%- for value in range(0, 86400) %}
      select dateadd(second, value, base) as time_value
      {%- if not loop.last %}
        union all
      {%- endif %}
    {%- endfor %}

  {%- else if level == 'minute' %}

    {# 1 day = 1440 minutes #}
    {%- for value in range(0, 1440) %}
      select dateadd(minute, value, base) as time_value
      {%- if not loop.last %}
        union all
      {%- endif %}
    {%- endfor %}

  {%- else %}

    {# 1 day = 24 hours #}
    {%- for value in range(0, 24) %}
      select dateadd(hour, value, base) as time_value
      {%- if not loop.last %}
        union all
      {%- endif %}
    {%- endfor %}

  {%- endif %}

{% endmacro %}