{% if target.type in ['sqlserver'] %}

{{
  config(
    materialized='table',
    post_hook='drop table if exists base_table_verify_get_time_dimension_second',
    pre_hook = """
      drop table if exists base_table_verify_get_time_dimension_second;
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
        select  top 86400
                N,
                row_number() over (order by N) as value
        from    E4
        order by 2
      )
      select  value
      into    base_table_verify_get_time_dimension_second
      from    EALL
    """
  )
}}

{{ dbt_resto.get_time_dimension(level='second', base_table='base_table_verify_get_time_dimension_second') }}

{% else %}

{{ dbt_resto.get_time_dimension(level='second') }}

{% endif %}